part of ThreeDart.Movers;

/// A mover which inverts the matrix from another mover.
class Invert implements Mover {
  Mover _mover;
  Events.Event _changed;
  Math.Matrix4 _mat;
  int _frameNum;

  /// Creates a new invert mover.
  Invert([Mover mover = null]) {
    this._mover = null;
    this._changed = null;
    this._mat = new Math.Matrix4.identity();
    this._frameNum = 0;

    this.mover = mover;
  }

  /// Emits when the mover has changed.
  Events.Event get changed {
    this._changed ??= new Events.Event();
    return this._changed;
  }

  /// The internal mover to invert.
  Mover get mover => this._mover;
  set mover(Mover mover) {
    if (this._mover != mover) {
      Mover prev = this._mover;
      this._mover = mover;
      if (mover != null) mover.changed.add(this._onChanged);
      if (prev != null) prev.changed.remove(this._onChanged);
      this._onChanged(new Events.ValueChangedEventArgs(this, "mover", prev, this._mover));
    }
  }

  /// Matrix from the last update.
  Math.Matrix4 get matrix => this._mat;

  /// Handles a child mover being changed.
  void _onChanged([Events.EventArgs args = null]) {
    this._changed?.emit(args);
  }

  /// Updates the contained mover then inverts the result.
  ///
  /// This updates with the given [state] and the [obj] this mover is attached to.
  Math.Matrix4 update(Core.RenderState state, Movable obj) {
    if (this._frameNum < state.frameNumber) {
      this._frameNum = state.frameNumber;
      this._changed?.suspend();
      Math.Matrix4 mat = this._mover?.update(state, obj)?.inverse();
      this._mat = mat ?? new Math.Matrix4.identity();
      this._changed?.resume();
    }
    return this._mat;
  }

  /// Determines if the given [other] variable is a [Invert] equal to this one.
  bool operator ==(var other) {
    if (identical(this, other)) return true;
    if (other is! Invert) return false;
    Invert grp = other as Invert;
    if (this._mover != grp._mover) return false;
    return true;
  }

  /// The string for this invert mover.
  String toString() {
    return "Invert";
  }
}
