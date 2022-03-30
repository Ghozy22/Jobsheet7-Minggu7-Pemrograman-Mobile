import 'package:flutter/material.dart';
import 'package:sqlite/model.dart';

class EntryForm extends StatefulWidget {

  final Item item;

  EntryForm(this.item);


  @override
  _EntryFormState createState() => _EntryFormState(item);
}

class _EntryFormState extends State<EntryForm> {

  Item item;


  _EntryFormState(this.item);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(item != null){
      nameController.text = item.name;
      priceController.text = item.price.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: item == null ? Text('tambah') : Text('Ubah'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget> [
            Padding(padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ) 
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: ElevatedButton
                  (onPressed: (){
                    if(item == null){
                      item = Item(nameController.text, int.parse(priceController.text));
                    } else {
                      item.name = nameController.text;
                      item.price = int.parse(priceController.text);
                    }

                    Navigator.pop(context, item);
                  },
                   child: Text('Save', textScaleFactor: 1.5,))
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}