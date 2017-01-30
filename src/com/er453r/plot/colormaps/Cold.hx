package com.er453r.plot.colormaps;

class Cold extends Colormap{
	private static var data:Array<Array<Float>> = [
		[0, 0, 0],
		[0, 0, 1],
		[0, 1, 1],
		[1, 1, 1]
	];

	public function new(buckets:UInt = 266){
		super(data, buckets);
	}
}
