classdef nnshiftdim_der < nntest
  properties (TestParameter)
    behavior = {'scalar','singleton','shiftdim'};
  end
  methods (Test)
    function basic(test, behavior)
      
      switch behavior
        case 'scalar'
          x_sz = [1,1];
          args = {};
        case 'singleton'
          x_sz = [1,1,5];
          args = {};
        case 'shiftdim'
          x_sz = [10,5,10,5];
          args = {3};
        otherwise 
          error('Unknown behavior.');
      end
      x = test.randn(x_sz) ;
      y = shiftdim(x,args{:}) ;
      dzdy = test.randn(size(y)) ;
      
      func_der = autonn_der(@shiftdim);
      dzdx = func_der(x,args{:},dzdy) ;
      test.der(@(x) shiftdim(x,args{:}), x, dzdy, dzdx, test.range * 1e-3) ;
      
    end
  end
end