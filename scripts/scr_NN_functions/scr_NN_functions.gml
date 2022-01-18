

// All neural network functions
// It should be noted that this is not an efficient way of coding neural networks, but it is fun
// to do stuff in gamemaker with it.



/// @ function scr_NN_pass_struct(_NN_parent, _NN_child){
/// @param {struct}	_NN1_parent	The structure containing all weights and biases of neural network
/// @param {struct} __NN_child  The structure we will copy all the values of the parent to

function scr_NN_pass_struct(_NN_parent, _NN_child){
	//pass on the thing
	
	// Parent
	var hidden_layer_weights1 = _NN_parent.hidden_layer_weights;
	var input_weights1 =_NN_parent.input_weights;
	var output_weights1 = _NN_parent.output_weights;
	var hidden_layer_bias1 =_NN_parent.hidden_layer_bias;
	var output_bias1 =_NN_parent.output_bias;
		
	// Child
	var hidden_layer_weights2 = _NN_child.hidden_layer_weights;
	var input_weights2 = _NN_child.input_weights;
	var output_weights2 = _NN_child.output_weights;
	var hidden_layer_bias2 = _NN_child.hidden_layer_bias;
	var output_bias2 = _NN_child.output_bias;


	for(var i=0;i<array_length(hidden_layer_weights2);i+=1){
		for(var j=0;j<array_length(hidden_layer_weights2[0]);j+=1){
			hidden_layer_weights2[i,j] = hidden_layer_weights1[i,j];
		}
	}
	
	for(var i=0;i<array_length(hidden_layer_bias2);i+=1){
		for(var j=0;j<array_length(hidden_layer_bias2[0]);j+=1){
			hidden_layer_bias2[i,j] = hidden_layer_bias1[i,j];
		}
	}
	for (var i=0;i<array_length(input_weights2);i+=1){
		input_weights2[i] = input_weights1[i] ;	
	}
	for (var i=0;i<array_length(output_weights2);i+=1){
		output_weights2[i] =  output_weights1[i];	
	}
	for (var i=0;i<array_length(output_bias2);i+=1){
		output_bias2[i] = output_bias1[i] ;	
	}



	var NN1_new = {
		hidden_layer_weights : hidden_layer_weights2,	
		input_weights : input_weights2,
		output_weights : output_weights2,
		hidden_layer_bias : hidden_layer_bias2,
		output_bias : output_bias2
	}
	
	return NN1_new;
	
	
}


/// @function  scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs)
/// @param {int} num_inputs			the number of input parameters in our neural network
/// @param {int} num_hidden_layers	The number of layers between input and output
/// @param {int} num_neurons		The number of neurons per layer
/// @param {int} num_outputs		The number of outputs we want to output


/// @description This will initialize our fully connected, dense neural network with random weights
/// @return		A struct containing the weights and biases we need in order to run the neural network in scr_NN_feedforward


function scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs){
	// num inputs = the number of inputs we have in the 
	
	var weight_n = num_neurons*num_neurons;
	

	
	// initialize the weights for the hidden layers
	var hidden_layer_weights =[]
	for (var i=0;i<num_hidden_layers-1;i+=1){
		for(var j=0;j<weight_n;j+=1){
			hidden_layer_weights[i,j] = random_range(-1,1);	
			//hidden_layer_weights[i,j] = 1;
		}
	}
	
	// initialize the weights for the input layer
	var input_weights = [];
	for (var i=0;i<num_inputs*num_neurons;i+=1){
		input_weights[i] = random_range(-1,1);	
		//input_weights[i] = 1;
	}
	
	//output weights
	var output_weights =[];
	for(var i=0;i<num_outputs*num_neurons;i+=1){
		output_weights[i] = random_range(-1,1);	
		
		//output_weights[i]=i;
	}
	
	
	//initialize the bias for the hidden layers
	var hidden_layer_bias = [];
	for (var i=0;i<num_hidden_layers;i+=1){
		for(var j=0;j<num_neurons;j+=1){
			hidden_layer_bias[i,j] = random_range(-1,1);	
			//hidden_layer_bias[i,j] = 1;
		}
	}
	
	
	//initialize the bias for the output
	var output_bias = [];
	for(i=0;i<num_outputs;i+=1){
		output_bias[i] = random_range(-1,1);
		//output_bias[i] = 1;
	}
	
	//add it to the struct
	var nn_struct = {
		hidden_layer_weights : hidden_layer_weights,	
		input_weights : input_weights,
		output_weights : output_weights,
		hidden_layer_bias : hidden_layer_bias,
		output_bias : output_bias
	}
	
	
	return nn_struct;
}




/// @function  scr_NN_feedforward(input_values, nn_struct)
/// @param {array} input_values		array containing the values we want to pass through the neural network, length must correspond with size of in inputarray neural network
/// @param {struct} nn_struct		The structure which  was defined in  scr_NN_initialize, which contains the weights and values


/// @description This will pass our values through a neural network and output the final values. Each neuron has a tanh activation function
/// @return		an array with the output values

function scr_NN_feedforward(input_values, nn_struct){


	/*
		This function produces the feedforward of the input values, and outputs the values
	*/
	
	
	var hidden_layer_weights = nn_struct.hidden_layer_weights;
	var input_weights = nn_struct.input_weights;
	var output_weights = nn_struct.output_weights;
	var hidden_layer_bias = nn_struct.hidden_layer_bias;
	var output_bias = nn_struct.output_bias;
	
	// Step 1 : multiply the input values with the input weights, which will give our first hidden layers
	neurons = []
	num_inputs = array_length(input_values);
	//num_neurons = sqrt(array_length(hidden_layer_weights[0]));
	num_neurons = array_length(input_weights)/array_length(input_values);
	
	for(i=0;i<array_length(input_weights);i+=num_inputs){
		neurons[i/num_inputs]=0
		for(j=i;j<i+num_inputs;j+=1){
			neurons[i/num_inputs] += input_weights[j]*input_values[j-i];
		}
		neurons[i/num_inputs] += hidden_layer_bias[0,i/num_inputs]
		
		
		//add activation function
		neurons[i/num_inputs] = scr_tanh(neurons[i/num_inputs]);
		
		
	}
	
	
	//step 2 : do the hidden layer multiplication
	for (i=0;i<array_length(hidden_layer_weights);i+=1){//for each of the hidden layers
		
		//initialize the new neuron layer
		new_neuron_layer = []
		for (j=0;j<num_neurons;j+=1){
			new_neuron_layer[j]=0;
		}

		for(j=0;j<array_length(hidden_layer_weights[i]);j+=num_neurons){
			for(k=j;k<j+num_neurons;k+=1){
				new_neuron_layer[j/num_neurons] += neurons[j/num_neurons]*hidden_layer_weights[i,k];	
			}	
		    new_neuron_layer[j/num_neurons] += hidden_layer_bias[i+1, j/num_neurons]; //add the bias
			
			//add activation function
			new_neuron_layer[j/num_neurons] = scr_tanh(new_neuron_layer[j/num_neurons]);
			
		}
		
		array_copy(neurons,0,new_neuron_layer,0,array_length(new_neuron_layer));

	}
	
	
	
	// Final step, multiply the neurons array times the output weights and output =
	
	//initialize output
	output = []
	for(i=0;i<array_length(output_bias);i+=1){
		output[i] = 0;	
	}
	
	for(i=0;i<array_length(output_bias);i+=1){
		for(j=0;j<array_length(neurons);j+=1){
			output[i] += output_weights[i*array_length(neurons)+j]*neurons[j];
		}
		output[i] += output_bias[i];
	}
	
	return output;
}



/// @function  scr_tanh(_val)
/// @param {float} _val			the value from the neuron we want to pass through the activation function

/// @description A activation function to use in our neural network
/// @return		the value we get after the tanh

function scr_tanh(_val){

	
	var _x = argument0;
	var _e = 2.718281828459;
	var _ans = (power(_e, 2*_x)-1)/(power(_e, 2*_x)+1);

	return(_ans);
	
	//return(_val);


}



/// @ function scr_NN_merge(_NN1, _NN2, _NN3)
/// @param {struct}	_NN1	The structure containing all weights and biases of neural network, parent 1
/// @param {struct} _NN2	The structure containing all weights and biases of neural network, parent 2
/// @param {struct} _NN3	The structure containing all weights and biases of neural network, child


function scr_NN_merge(_NN1, _NN2, _NN3){

	//parent 1
	var hidden_layer_weights1 = _NN1.hidden_layer_weights;
	var input_weights1 = _NN1.input_weights;
	var output_weights1 = _NN1.output_weights;
	var hidden_layer_bias1 = _NN1.hidden_layer_bias;
	var output_bias1 = _NN1.output_bias;
		
	// parent 2
	var hidden_layer_weights2 = _NN2.hidden_layer_weights;
	var input_weights2 = _NN2.input_weights;
	var output_weights2 = _NN2.output_weights;
	var hidden_layer_bias2 = _NN2.hidden_layer_bias;
	var output_bias2 = _NN2.output_bias;

	//child
	var hidden_layer_weights3 = _NN3.hidden_layer_weights;
	var input_weights3 = _NN3.input_weights;
	var output_weights3 = _NN3.output_weights;
	var hidden_layer_bias3 = _NN3.hidden_layer_bias;
	var output_bias3 = _NN3.output_bias;





	for(var i=0;i<array_length(hidden_layer_weights3);i+=1){
		for(var j=0;j<array_length(hidden_layer_weights3[0]);j+=1){
			hidden_layer_weights3[i,j] = random(1)<0.5 ? hidden_layer_weights1[i,j] : hidden_layer_weights2[i,j];
		}
	}
	
	for(var i=0;i<array_length(hidden_layer_bias3);i+=1){
		for(var j=0;j<array_length(hidden_layer_bias3[0]);j+=1){
			hidden_layer_bias3[i,j] = random(1)<0.5 ? hidden_layer_bias1[i,j] : hidden_layer_bias2[i,j];
		}
	}
	
	for (var i=0;i<array_length(input_weights3);i+=1){
		input_weights3[i] = random(1)<0.5 ? input_weights1[i] : input_weights2[i];	
	}
	for (var i=0;i<array_length(output_weights3);i+=1){
		output_weights3[i] = random(1)<0.5 ? output_weights1[i] : output_weights2[i];	
	}
	for (var i=0;i<array_length(output_bias3);i+=1){
		output_bias3[i] = random(1)<0.5 ? output_bias1[i] : output_bias2[i];	
	}


	var NN3_new = {
		hidden_layer_weights : hidden_layer_weights3,	
		input_weights : input_weights3,
		output_weights : output_weights3,
		hidden_layer_bias : hidden_layer_bias3,
		output_bias : output_bias3
	}
	
	
	return NN3_new;


}





/// @ function scr_NN_mutate(_NN1, _chance_to_mutate, _frac_to_mutate, _min_val)
/// @param {struct}	_NN1	The structure containing all weights and biases of neural network, which we want to mutate
/// @param {float} _chance_to_mutate	fraction of the neurons we wish to mutate
/// @param {float} _frac_to_mutate		how much to mutate, so if 0.2, neuron value = nueron_value * random_range(0.8,1.2)
/// @param {float} _min_val				The minimum value each weight and bias should be, so we don't get dead neurons


function scr_NN_mutate(_NN1, _chance_to_mutate, _frac_to_mutate, _min_val){

	//struct to mutate
	var hidden_layer_weights1 = _NN1.hidden_layer_weights;
	var input_weights1 = _NN1.input_weights;
	var output_weights1 = _NN1.output_weights;
	var hidden_layer_bias1 = _NN1.hidden_layer_bias;
	var output_bias1 = _NN1.output_bias;
	


	var rand_range_min = 1-_frac_to_mutate;
	var rand_range_max = 1+_frac_to_mutate;


	for(var i=0;i<array_length(hidden_layer_weights1);i+=1){
		for(var j=0;j<array_length(hidden_layer_weights1[0]);j+=1){
			hidden_layer_weights1[i,j] = random(1)<_chance_to_mutate ? hidden_layer_weights1[i,j] : hidden_layer_weights1[i,j] * random_range(rand_range_min, rand_range_max);
			if abs(hidden_layer_weights1[i,j])>_min_val{
				hidden_layer_weights1[i,j] = sign(hidden_layer_weights1[i,j])*_min_val;	
			}
		}
	}
	
	for(var i=0;i<array_length(hidden_layer_bias1);i+=1){
		for(var j=0;j<array_length(hidden_layer_bias1[0]);j+=1){
			hidden_layer_bias1[i,j] = random(1)<_chance_to_mutate ? hidden_layer_bias1[i,j] : hidden_layer_bias1[i,j] * random_range(rand_range_min, rand_range_max);
			if abs(hidden_layer_bias1[i,j])>_min_val{                                   
				hidden_layer_bias1[i,j] = sign(hidden_layer_bias1[i,j])*_min_val;	
			}
		}
	}
	
	for (var i=0;i<array_length(input_weights1);i+=1){
		input_weights1[i] = random(1)<_chance_to_mutate ? input_weights1[i] : input_weights1[i]* random_range(rand_range_min, rand_range_max);
		if abs(input_weights1[i])>_min_val{                                   
			input_weights1[i] = sign(input_weights1[i])*_min_val;	
		}
	}
	for (var i=0;i<array_length(output_weights1);i+=1){
		output_weights1[i] = random(1)<_chance_to_mutate ? output_weights1[i] : output_weights1[i]* random_range(rand_range_min, rand_range_max);
		if abs(output_weights1[i])>_min_val{                                   
			output_weights1[i] = sign(output_weights1[i])*_min_val;	
		}
	}
	for (var i=0;i<array_length(output_bias1);i+=1){
		output_bias1[i] = random(1)<_chance_to_mutate ? output_bias1[i] : output_bias1[i]* random_range(rand_range_min, rand_range_max);
		if abs(output_bias1[i])>_min_val{                                   
			output_bias1[i] = sign(output_bias1[i])*_min_val;	
		}
	}


	var NN1_new = {
		hidden_layer_weights : hidden_layer_weights1,	
		input_weights : input_weights1,
		output_weights : output_weights1,
		hidden_layer_bias : hidden_layer_bias1,
		output_bias : output_bias1
	}
	
	
	return NN1_new;


}





