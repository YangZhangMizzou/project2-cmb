import lasagne

RAW_CHANNELS = 441

def build_cnn(input_var=None):

    # Input layer, as usual:
    network = lasagne.layers.InputLayer(shape=(1, RAW_CHANNELS, None, None), input_var=input_var)

    network = lasagne.layers.batch_norm(lasagne.layers.Conv2DLayer(
            network, num_filters=64*2, filter_size=1,
            nonlinearity=None,
            W=lasagne.init.GlorotUniform('relu')))

    network = lasagne.layers.FeaturePoolLayer(network, 2)

    for layer in range(14):
        network = lasagne.layers.batch_norm(lasagne.layers.Conv2DLayer(
                network, num_filters=64, filter_size=5, pad='same',
                nonlinearity=lasagne.nonlinearities.rectify,
                W=lasagne.init.GlorotUniform('relu')), gamma=None)

    network = lasagne.layers.batch_norm(lasagne.layers.Conv2DLayer(
            network, num_filters=1, filter_size=1,
            nonlinearity=lasagne.nonlinearities.sigmoid))

    return network
