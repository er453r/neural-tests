package com.er453r.neural.tests;

class DepthLearning extends NeuronMutator{
	public function new(){}

	override public function onStep(neuron:Neuron){
		// creates gradient for the singal to propagate into
		var max:Float = neuron.outputs[0].output.learning * neuron.outputs[0].weight;
		var maxLearner:Synapse = neuron.outputs[0];
		var found:Bool = false;

		for(output in neuron.outputs){
			var value:Float = output.output.learning * output.weight;

			if(max < value){
				max = value;
				maxLearner = output;
				found = true;
			}
		}

		neuron.learn = maxLearner.output.learning * maxLearner.weight;

		// makes the signal follow the steepest slope
		if(found){
			maxLearner.weight = maxLearner.weight * 0.9 + 0.1;
		}
	}
}
