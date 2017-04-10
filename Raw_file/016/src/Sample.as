package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class Sample extends Sprite
	{
		public var refList:Array = [ { state: 0, text: "toy" },
									 { state: 1, text: "toy" },
									 { state: 2, text: "toy" },
									 { state: 3, text: "toy" },
									 { state: 4, text: "toy" } 
								   ];
		public function Sample() 
		{
			for (var i:int = 0; i < refList.length; i++) 
			{
			trace( refList[i].state );
			}
			
		}
		
	}

}

/*Basic Usage of the Tween Class
Easing Variations
Tween Methods
Tween Events
Misc Tween Properties
Basic Usage of the Tween Class

The Tween Class is a ActionScript class that can be used to tween any property of any object. By the term tween we mean here the gradual increase or decrease of the value of a property which can bring about an animation. This could be the increase of transparency, the decrease in width, or the movement from left to right of any object.
The Tween Class is not included by default in a Flash movie and must be imported before it can be used, Adobe did this to ensure to help making SWF files smaller so that the Class is included only in movies that require it. To import this class you must use the import directive at the beginning before you start your actual code. Here is the code you need:
import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent;
The Tween Class must be used through an instance of it. When instantiating the Tween Class you must provide the parameters required by the TWeen Class. This process is done by the manner illustrated in the following generalized code:
var myTween:Tween = new Tween(object, "property", EasingType, begin, end, duration, useSeconds);
All of these parameters must be provided when the class is instantiated. Here is what these parameters mean:
object - This is the instance name of the object which will be animated. Example: my_box, gallery_mc, myTextField_txt.
property - This is the name of the property which will be animated, it must be specified as a string (between quotation marks). Example: "alpha", "scaleX", "scaleY", "x", "y".
EasingType - The easing type will determine how the tween animation will flow. We are going to explain this more in the next section of the tutorial. Examples: Strong.EaseIn, Elastic.EaseOut, Back.EaseInOut.
begin - This is the position from which the animation will start, it must be specified as a number.
end - This is the position at which the animation will stop, it must be specified at as a number.
duration - This is the period for which the animation will run, the default unit for it is frames, however, the unit can be set in seconds if you set the next parameter as true.
useSeconds - Set this parameter to true if you want to the duration to be measured in seconds instead of frames.
So for example, if we want to move an object called my_box along the x axis, from position 40 to position 300 in an animation that takes 5 seconds we would write it this way:
var myTween:Tween = new Tween(my_box, "x", Strong.easeOut, 40, 300, 5, true);
I intentionally did not talk about the EasingType because we will cover that in the next section below.
Running your own example

Create a new AS3 Flash movie, draw a square or any other shape, convert it to Movie Clip symbol (press F8 to do this) and assign the instance name my_box to it using the Properties Inspector. You will then have to right-click the only frame on the timeline and access the Actions panel. Paste the code below and test your movie (Ctrl+Enter) to see it move:
import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent;

var myTween:Tween = new Tween(my_box, "x", Strong.easeOut, 40, 300, 5, true);
You can animate different properties and try out different values by changing the parameters. For example to make your object fade out make alpha decrease from 1 to zero in 10 seconds:
var myTween:Tween = new Tween(my_box, "alpha", Strong.easeOut, 1, 0, 10, true);
Using Easing Classes to Alter Tween Motion

It is possible to alter the motion flow of the tween by using different easing classes. Easing is the acceleration or the deceleration of the speed at which the object is moving. It is quite hard to explain in words, but it is easy to understand by just looking at it (Check the example below).
There are basically six easing types:
Regular: the motion speed will gradually increase or decrease in speed as specified by the easing method.
Bounce: the motion will bounce back a few steps when it reaches the end position before settling at it.
Back: the motion will go beyond the end position before bouncing back into it.
Elastic: a mixture of Bounce and Back effects combined.
Strong: a more emphasized Regular effect.
None: no easing, the motion will not speed up.
Each of these functions must be then be configured using one of the easing methods to determine at which part of the tween it shall apply the effect, i.e. at the start of it, the end of it, both, or none:
easeIn: - The tween effect is applied to the start of the animation.
easeOut: - The tween effect is applied to the end of the animation.
easeInOut: - the tween effect is applied to the start and end of the animation.
easeNone: - no tweening effect is applied, to be used with the None tween function.
 
You should now be able to use the Tween Class to animate any object you wish. The rest of the tutorial will explain Tween Methods, which are actions that can be performed on the Tween, Tween Event, which are events that can be reacted to by the player, and a couple of Tween Properties which can be helpful in advanced projects.
Tween Methods

The Tween Class has several methods which let you command it to take specific actions such as (a) stopping the tween at any time, (b) playing it over again, or (c) telling it to play in reverse. Each of the methods below are to be applied directly onto an instance of the tween class.
Tween.stop() does what it says, it tells the tween to stop at its current position.
Tween.resume() tells the tween to resume playback from its current position, this method is used after invoking the .stop() method.
Tween.start() tells the tween to start playback from the initial starting point, this is not the same as .resume(). This method actually restarts the tween.
Tween.continueTo(finish, duration) tells the tween to stop the current animation and continue it's moving to a new point starting from its current location.
Tween.fforward() tells the tween to stop the animated object at the end position of the animation instantly.
Tween.rewind() tells the tween to go back and stop at its starting point.
Tween.nextFrame() tells the tween to go to the next frame.
Tween.preFrame() tells the tween to go back to the previous frame.
Tween.yoyo() tells the animation to play in reverse.
The example below creates a Tween, but then instantly stops it. An event listener is attached to a button that tells the tween to start when the button is clicked. As you can see, the methods are directly invoked on the instance of the Tween Class.
var myTween:Tween = new Tween(my_box, "alpha", Strong.easeOut, 1, 0, 10, true);
myTween.stop();

my_btn.addEventListener(MouseEvent.CLICK, onClick);
function onClick(e:MouseEvent){
myTween.start();
}
Tween Events

Tween Events let us track what is happening to the Tween and react to certain events such as the completion of the tween motion. This is helpful when you want to, for example, play a certain frame after the tween finishes.
The TweenEvent Class provides the following events:
TweenEvent.MOTION_FINISH - This event is triggered when the motion finishes by reaching its end point.
TweenEvent.MOTION_STOP - This event is triggered when the motion is stopped by the .stop method.
TweenEvent.MOTION_START - This event is triggered when the motion is started using the .start method.
TweenEvent.MOTION_RESUME - This event is triggered when the motion is resumed by the .resume method.
TweenEvent.MOTION_CHANGE - This event is continuously triggered while the motion is running.
TweenEvent.MOTION_LOOP - This event is supposed to be triggered when the motion is restarted through a looping action. I do not know what the means as I tried to use it with .yoyo() and it was never triggered.
All of these events can be registered by the Tween by using the .addEventListener() method and specifying a listener function - just like all other events in AS3. The example below registers the Tween instance with the MOTION_FINISH event and executes the .yoyo() method when it's done. This effectively makes the tween loop forever.
import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent; 

var myTween = new Tween(my_mc, "x", Strong.easeInOut, 100,300, 1, true); 

myTween.addEventListener(TweenEvent.MOTION_FINISH, onFinish);
function onFinish(e:TweenEvent):void {
myTween.yoyo();
}
Please review the AS3 Event Handling Tutorial to learn more about this subject.
It is worth noting at this instance that it is possible to refer to the tween by using the keyword target from within the listener function instead of explicitly writing down the instance name. Here is an updated example:
import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent; 

var myTween = new Tween(my_mc, "x", Strong.easeInOut, 100,300, 1, true); 

myTween.addEventListener(TweenEvent.MOTION_FINISH, onFinish);
function onFinish(e:TweenEvent):void {
e.target.yoyo();
}
This can let the event listener be used with more than one tween at the same time as it does not explicitly refer to an actual tween - a good idea for saving time and making things more organized.
Misc Tween Properties

In this final short section of the tutorial I will tell you about two properties of the Tween Class which can be accessed to retrieve information you might need. Both of these properties must be accessed directly from the instance of the Tween Class. Here they are:
obj - is a reference to the object currently being tweened. Using this property is helpful if you need to refer to it later using an event handler. The example below will set the alpha property to .5 when the tween finishes:

import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent; 

var myTween = new Tween(my_mc, "x", Strong.easeInOut, 100,300, 1, true); 

myTween.addEventListener(TweenEvent.MOTION_FINISH, onFinish);
function onFinish(e:TweenEvent):void {
myTween.obj.alpha=0.5;
}
position - is a reference to the current position of the tween. This property is usually accessed through out the motion of the tween. The example below outputs the current position in the output window when the movie is tested:
import fl.transitions.Tween;
import fl.transitions.easing.*;
import fl.transitions.TweenEvent; 

var myTween = new Tween(my_mc, "x", Strong.easeInOut, 100,300, 1, true); 

myTween.addEventListener(TweenEvent.MOTION_CHANGE, onChange);
function onChange(e:TweenEvent):void {
trace(myTween.position);
}
These two properties are the most commonly used tween properties. If you would like to learn about the other ones which are not commonly used please refer to the ActionScript reference.
This concludes our tutorial. I hope that you learnt something helpful. Feel free to post any questions or comments you have the Oman3D Forum.
- End of Tutorial.
 * */