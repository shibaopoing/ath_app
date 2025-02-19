
import 'package:flutter/material.dart';



class ChipDemo extends StatefulWidget {

  @override

  _ChipDemoState createState() => _ChipDemoState();

}



class _ChipDemoState extends State<ChipDemo> {

  List<String> _tags = [

    'Apple',

    'Banana',

    'Lemon',

  ];

  String _action = 'Nothings';

  // 这个需要和FloatButton 配合使用

  List<String> _selected = [];

  String _choice = 'Lemon';

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),

      body: Container(

        padding: EdgeInsets.all(16.0),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            // 使用row 控件超出部分会报黄色 RITHT OVERFLOWED BY 325 PIxELS

/*            Wrap(

              // 列之间的间隔

              spacing: 8.0,

              // 行之间的间隔

              runSpacing: 8.0,

              children: <Widget>[

                Chip(

                  label: Text('Life'),

                ),

                Chip(

                  label: Text('Sunset'),

                  backgroundColor: Colors.orange,

                ),

                Chip(

                  label: Text('liuan'),

                  avatar: CircleAvatar(

                    backgroundColor: Colors.green,

                    child: Text('安'),

                  ),

                ),

                Chip(

                  label: Text('liuan'),

                  avatar: CircleAvatar(

                    backgroundImage: NetworkImage(

                        'https://avatar.csdn.net/9/3/9/1_mp624183768.jpg?1547430707'),

                  ),

                ),

                Chip(

                  label: Text('City'),

                  // 删除按钮

                  onDeleted: () {},

                  deleteIcon: Icon(Icons.delete),

                  deleteIconColor: Colors.redAccent,

                  // 长按删除按钮会出来此提示

                  deleteButtonTooltipMessage: "REmove this tag",

                ),



                Divider(

                  color: Colors.grey,

                  height: 32.0,

                  //左边缩进

                  // indent: 32.0,

                ),

                //  列表chip

                Wrap(

                    spacing: 8.0,

                    children: _tags.map((tag) {

                      return Chip(

                        label: Text(tag),

                        onDeleted: () {

                          setState(() {

                            _tags.remove(tag);

                          });

                        },

                      );

                    }).toList()),

                // 动作碎片

                Divider(

                  color: Colors.grey,

                  height: 32.0,

                  //左边缩进

                  // indent: 32.0,

                ),

                //  列表chip

                Container(

                  width: double.infinity,

                  child: Text('ActionChip:$_action'),

                ),

                Wrap(

                  spacing: 8.0,

                  children: _tags.map((tag) {

                    return ActionChip(

                      label: Text(tag),

                      onPressed: () {

                        setState(() {

                          _action = tag;

                        });

                      },

                    );

                  }).toList(),

                ),



                // 过滤碎片

                Divider(

                  color: Colors.grey,

                  height: 32.0,

                  //左边缩进

                  // indent: 32.0,

                ),

                //  列表chip

                Container(

                  width: double.infinity,

                  child: Text('FilterChip:$_selected.toString()'),

                ),

                Wrap(

                  spacing: 8.0,

                  children: _tags.map((tag) {

                    return FilterChip(

                      label: Text(tag),

                      selected: _selected.contains(tag),

                      onSelected: (value) {

                        setState(() {

                          if (_selected.contains(tag)) {

                            _selected.remove(tag);

                          } else {

                            _selected.add(tag);

                          }

                        });

                      },

                    );

                  }).toList(),

                ),



                // 选择碎片

                Divider(

                  color: Colors.grey,

                  height: 32.0,

                  //左边缩进

                  // indent: 32.0,

                ),

                //  列表chip

                Container(

                  width: double.infinity,

                  child: Text('ChoiceChip:$_choice'),

                ),

                Wrap(

                  spacing: 8.0,

                  children: _tags.map((tag) {

                    return ChoiceChip(

                      label: Text(tag),

                      selected: _choice==tag,

                      selectedColor: Colors.black,

                      onSelected: (value) {

                        setState(() {

                          _choice=tag;

                        });

                      },

                    );

                  }).toList(),

                ),

              ],

            ),*/
            CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        const Text('I\'m dedicating every day to you'),
                        const Text('Domestic life was never quite my style'),
                        const Text('When you smile, you knock me out, I fall apart'),
                        const Text('And I thought I was so smart'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
              ],
            )
          ],

        ),

      ),

      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.restore),

        onPressed: () {

          setState(() {

            _tags = [

              'Apple',

              'Banana',

              'Lemon',

            ];

            _selected = [];

            _choice='Lemon';

          });

        },

      ),

    );

  }

}
