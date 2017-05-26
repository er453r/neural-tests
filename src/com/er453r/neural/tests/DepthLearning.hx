package com.er453r.neural.tests;

class DepthLearning extends NeuronMutator{
	public function new(){}

	override public function onStep(neuron:Neuron){
		// creates gradient for the singal to propagate into
		var max:Float = 0;
		var maxLearner:Synapse = neuron.outputs[0];

		for(output in neuron.outputs){
			var value:Float = output.output.learning * output.weight;

			if(max < value){
				max = value;
				maxLearner = output;
			}
		}

		neuron.learn = maxLearner.output.learning * maxLearner.weight;

		// makes the signal follow the steepest slope
		maxLearner.weight += 0.001;
	}
}
