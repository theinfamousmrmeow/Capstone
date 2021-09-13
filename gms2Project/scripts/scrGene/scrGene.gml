///@desc
///@param
function scrGene(){

}

function Chromosone(_type=choose(obj_blobman,obj_ironsuit,obj_octus),_placement=random(1),_timer=random(100)) constructor
{
    type = _type;
	placement = _placement;
	timer = _timer;

}

function Gene() constructor {
	//Gene consists of Chromosones in a list
	chromosones = ds_list_create();
	repeat(10){
		ds_list_add(chromosones,new Chromosone());
	}
}

