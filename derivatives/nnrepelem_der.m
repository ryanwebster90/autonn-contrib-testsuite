classdef nnrepelem_der < nntest
  properties (TestParameter)
    behavior = {'scalar','vector','tensor'};
  end
  methods (Test)
    function basic(test, behavior)
      
      switch behavior
        case 'scalar'
          x_sz = [1,1];
          rep_sz = {5};
        case 'vector'
          x_sz = [5,1];
          rep_sz = {5};
        case 'tensor'
          x_sz = [10,3,10,5];
          rep_sz = {2,4,1,3};
        otherwise 
          error('Unknown behavior.');
      end
      x = test.randn(x_sz) ;
      y = repelem(x,rep_sz{:}) ;
      dzdy = test.randn(size(y)) ;
      dzdx = repelem_der(x,rep_sz{:},dzdy) ;
      test.der(@(x) repelem(x,rep_sz{:}), x, dzdy, dzdx, test.range * 1e-3) ;
      
    end
  end
end