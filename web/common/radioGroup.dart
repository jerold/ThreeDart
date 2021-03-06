part of ThreeDart.web.common;

/// The handler called when the selection is changed.
typedef void radioSelectedHndl();

/// A group of radio buttons.
class RadioGroup {

  /// The name of the element for the radio button group.
  String _elemId;

  /// Indicates if the group should be kept in the URL.
  bool _keepInURL;
  
  /// The element to fill with radio buttons.
  html.Element _elem;

  /// Creates a new radio button group in the element with the given [elemId] name.
  RadioGroup(this._elemId, [this._keepInURL = true]) {
    this._elem = html.document.getElementById(this._elemId);
    if (this._elem == null) {
      throw "Failed to find $_elemId for RadioGroup";
    }
  }

  /// Adds a new radio button to this group.
  void add(String text, radioSelectedHndl hndl, [bool selectedByDefault = false]) {
    if (this._elem == null) return;

    bool itemIsChecked = false;
    String selectedItem = Uri.base.queryParameters['$_elemId'];
    if (selectedItem == null) {
      if (selectedByDefault) {
        itemIsChecked = true;
        hndl();
        this._updateUrl(text);
      }
    } else if (selectedItem == text) {
      itemIsChecked = true;
      hndl();
    }

    html.LabelElement label = new html.LabelElement()..style.whiteSpace = "nowrap";
    this._elem.children.add(label);
    html.RadioButtonInputElement checkBox = new html.RadioButtonInputElement()
      ..checked = itemIsChecked
      ..name = this._elemId;
    checkBox.onChange.listen((_) {
      if (checkBox.checked) {
        hndl();
        this._updateUrl(text);
      }
    });
    label.children.add(checkBox);

    html.SpanElement span = new html.SpanElement()..text = text;
    label.children.add(span);

    this._elem.children.add(new html.BRElement());
  }

  /// Updates the URL for changes in the radio group.
  void _updateUrl(String text) {
    if (!this._keepInURL) return;

    Uri current = Uri.base;
    Map<String, String> parameters = new Map<String, String>.from(current.queryParameters);
    parameters[this._elemId] = text;

    Uri newUrl = current.replace(queryParameters: parameters);
    html.window.history.replaceState('', '', newUrl.toString());
  }
}
