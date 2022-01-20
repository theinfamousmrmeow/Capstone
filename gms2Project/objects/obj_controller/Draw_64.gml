/// @description 
event_inherited();
if (DEBUG){
	var _x=12;
	var _y=32;
	draw_text(_x,_y,"$$$: "+string(points));
	draw_text(_x,_y+16,"GENE :"+string(global.population.currentGene)+"/"+string(ds_list_size(global.population.genes)));
	draw_text(_x,_y+32,"FITNESS :"+string(fitness));
	draw_text(_x,_y+48,"CHROMS :\n"+string_replace_all(string(gene.toString()),";","\n"));
}