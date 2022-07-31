# qb-moneywash
This is a modified version of Money Wash script.

 ## Installation
### Manual

Make sure to add following items in qb-core/shared/items.lua:

```lua
['markedcash'] 				 = {['name'] = 'markedcash', 			  	  	['label'] = 'Marked Cash', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'markedbills.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cash?'},
['markedbag'] 				 = {['name'] = 'markedbag', 			  	  	['label'] = 'Marked Bag', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'markedbills.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Money Bag?'},
['emptybag'] 				 = {['name'] = 'emptybag', 			  	  	['label'] = 'Empty Bag', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'markedbills.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Empty Bag?'},
```


Make sure to add following in qb-inventory/html/js/app.js below marked bills if you want to see how much money there is in a money bag when hovering over item:

```js
} else if (itemData.name == "markedbag") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p><strong>Worth: </strong><span>$" +
        itemData.info.worth +
        "</span></p>"
);
```