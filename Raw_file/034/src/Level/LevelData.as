package Level 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class LevelData extends Sprite
	{
		public var arrData:Array = [];
		public var arrDataInv:Array = [];
		public var isLvlSpecial:Boolean = false;
		
		public function LevelData() 
		{
			
		}
		public function setLevelInvData( lvl:Number ):Array {
			arrDataInv = new Array();
			switch( lvl ) {
			case 1:
				arrDataInv = [ { state: 1 },{ state: 2 },{ state: 2 },{ state: 2 },{ state: 2 } ];
			break;
			case 2:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 2 },{ state: 2 },{ state: 2 } ];
				break;
			case 3:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 2 },{ state: 2 } ];
			break;
			case 4:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 2 },{ state: 2 } ]; 
			break;
			case 5:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 2 } ];
			break;
			case 6:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 1 } ];
			break;
			case 7: // not in use
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 2 } ];
			break;
			case 8:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 2 } ];
			break;
			case 9:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 1 } ];
			break;
			case 10:
				arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 1 } ];
			break;
			}
			
			return arrDataInv;
		}
		
		public function setLevel( lvl:Number ):Array {
			arrData = new Array();
			
			switch( lvl ) {
				case 1:
					isLvlSpecial = false; // only boy
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 1 },
								{ state: 0, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 0, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 0, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 0, label: "food", lvl: 1, name:"food_1"},
								{ state: 0, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			case 2:
					isLvlSpecial = false; // has girl 
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 3 },
								{ state: 1, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 1, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 0, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 0, label: "food", lvl: 1, name:"food_1"},
								{ state: 0, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			case 3:
					isLvlSpecial = false; // has 2 boy & girl 
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 5 },
								{ state: 1, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 1, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 1, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 0, label: "food", lvl: 1, name:"food_1"},
								{ state: 0, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 4:
					isLvlSpecial = true; //Has random
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 7 },
								{ state: 1, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 1, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 1, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 0, label: "food", lvl: 1, name:"food_1"},
								{ state: 0, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;

			case 5:
					isLvlSpecial = false; //has light
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 8 },
								{ state: 1, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 1, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 1, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 1, label: "food", lvl: 1, name:"food_1"},
								{ state: 1, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			case 6: // not in use 
					isLvlSpecial = false; //has light
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"toy_1", maxNum: 10 },
								{ state: 1, label: "toy", lvl: 2, name:"toy_2"},
								{ state: 1, label: "girly", lvl: 1, name:"girly_1"},
								{ state: 1, label: "girly", lvl: 2, name:"girly_2"},
								{ state: 1, label: "food", lvl: 1, name:"food_1"},
								{ state: 1, label: "food", lvl: 2, name:"food_2"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
				
			case 7:
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"gui1", maxNum: 5 },
								{ state: 1, label: "toy", lvl: 2, name:"gui2"},
								{ state: 1, label: "girly", lvl: 1, name:"3"},
								{ state: 1, label: "girly", name:"4"},
								{ state: 1, label: "food", lvl: 1, name:"5"},
								{ state: 1, label: "food", lvl: 2, name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 8:
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"gui1", maxNum: 5 },
								{ state: 1, label: "toy", lvl: 2, name:"gui2"},
								{ state: 1, label: "girly", lvl: 1, name:"3"},
								{ state: 1, label: "girly", name:"4"},
								{ state: 1, label: "food", lvl: 1, name:"5"},
								{ state: 1, label: "food", lvl: 2, name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
				
			case 9:
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"gui1", maxNum: 5 },
								{ state: 1, label: "toy", lvl: 2, name:"gui2"},
								{ state: 1, label: "girly", lvl: 1, name:"3"},
								{ state: 1, label: "girly", name:"4"},
								{ state: 1, label: "food", lvl: 1, name:"5"},
								{ state: 1, label: "food", lvl: 2, name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
				
			case 10:
					arrData	= [ { state: 1, label: "toy", lvl: 1, name:"gui1", maxNum: 5 },
								{ state: 1, label: "toy", lvl: 2, name:"gui2"},
								{ state: 1, label: "girly", lvl: 1, name:"3"},
								{ state: 1, label: "girly", name:"4"},
								{ state: 1, label: "food", lvl: 1, name:"5"},
								{ state: 1, label: "food", lvl: 2, name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "girly", name:"8"},
								{ state: 0, label: "random", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			}
		
			if ( isLvlSpecial ) {
				arrData.push( { state: 1, label: "random", lvl:1 } );
			}
			
			
			return arrData;
		}
	//end	
	}
}