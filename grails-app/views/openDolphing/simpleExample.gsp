<%--
  Created by IntelliJ IDEA.
  User: jbobesba
  Date: 04/06/2014
  Time: 12:50
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Basic Functional Tests</title>
    %{--<r:require module="openDolphing" />--}%
    <script data-main="js/opendolphin" src="js/require.js"></script>
</head>

<body>

<h1>Basic Functional Tests written with inline JavaScript</h1>

<p>Enter text here to see the instant update of the connected labels:</p>

<p>
    <input id="instant-update-input" type="text" value=""></p>

<p>
    <button id="rebase-button" disabled='true'>Rebase</button>
    <button id="reset-button" disabled='true'>Reset</button>
</p>

<p>
    IsDirty
    <input id="dirty-status" type="checkbox"/>
</p>

<p>Instantly updated label from the same Attribute:

<div id="instant-update-label" class="label">unchanged</div>
</p>

<p>Instantly updated label from an Attribute with the same qualifier:

<div id="qualified-label" class="label">unchanged</div>
</p>


<script>

    require([ 'opendolphin' ], function (dol) {

        // setting up the dolphin
        const dolphin = dol.dolphin(null, false);
        // make two attributes
        const instantUpdateAttribute = dolphin.attribute("instant-update", "same-qualifier", "");
        const qualifiedAttribute = dolphin.attribute("qualified-update", "same-qualifier", "");
        // and put each into its own presentation model
        dolphin.presentationModel(undefined, undefined, instantUpdateAttribute);
        dolphin.presentationModel(undefined, undefined, qualifiedAttribute);

        // html elements to bind against
        const instantUpdateInput = document.getElementById("instant-update-input");
        const rebaseButton = document.getElementById("rebase-button");
        const resetButton = document.getElementById("reset-button");
        const dirtyStatus = document.getElementById("dirty-status");
        const instantUpdateLabel = document.getElementById("instant-update-label");
        const qualifiedLabel = document.getElementById("qualified-label");

        // bind input of textfield to attribute
        instantUpdateInput.oninput = function (event) {
            instantUpdateAttribute.setValue(instantUpdateInput.value);
        };
        // bind other direction as well (e.g. for rebase)
        instantUpdateAttribute.onValueChange(function (event) {
            instantUpdateInput.value = event.newValue;
        });

        // bind dirty of attribute to value of checkbox
        instantUpdateAttribute.onDirty(function (event) {
            dirtyStatus.checked = event.newValue;
        });
        // bind dirty of attribute to enabled of rebaseButton
        instantUpdateAttribute.onDirty(function (event) {
            rebaseButton.disabled = !event.newValue;
        });
        // bind dirty of attribute to enabled of resetButton
        instantUpdateAttribute.onDirty(function (event) {
            resetButton.disabled = !event.newValue;
        });
        // bind value of attribute to value of instantUpdateLabel
        instantUpdateAttribute.onValueChange(function (event) {
            instantUpdateLabel.innerHTML = event.newValue;
        });
        // bind qualified attribute to value of qualifiedLabel
        qualifiedAttribute.onValueChange(function (event) {
            qualifiedLabel.innerHTML = event.newValue;
        });

        //rebase
        rebaseButton.onclick = function () {
            instantUpdateAttribute.rebase();
        };
        //reset
        resetButton.onclick = function () {
            instantUpdateAttribute.reset();
        };
    });
</script>

</body>
</html>