import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final Widget trailing , child;
  final String title;
  final double height , childHeight;
  final bool isBig;

  const CustomAppBar({
    Key key,
    //this.leading,
    this.trailing,
    this.child,
    this.title,
    this.height,
    this.childHeight,
    this.isBig,
  }): super(key: key);

@override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
        clipper: _AppBarClipper(
          childHeight:childHeight,
        
          isBig: isBig
        ),
        child: Container(
          padding: const EdgeInsets.only(top:32),
          color: Colors.lightBlue[900],
          height: 90,
          
           
          child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max ,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             FlatButton(
                onPressed: null,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize:18,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),),trailing
            ],)
        ),
      ),
      
      ],
    );
  }

}

class _AppBarClipper extends CustomClipper<Path>{

  final bool isBig;
  final double childHeight;

  _AppBarClipper({@required this.isBig, @required this.childHeight});

  Path getClip(Size size){
    double height = isBig ? size.height - childHeight : size.height;
    Path path = Path();

    path.moveTo(0, height - 0);
    path.quadraticBezierTo(size.width, height, size.width, height - 0);
    path.lineTo(size.width, 0);
    path.lineTo(0,0);

    return path;
  }

  bool shouldReclip (CustomClipper<Path> oldClipper) => true;
}
