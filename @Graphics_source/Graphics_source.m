classdef Graphics_source < handle
    %GRAPHICS_SOURCE A meta class for keeping track of graphics objects and
    %their data sources
    %  
    %   obj = Graphics_source(target_axis,type,axis_lims,xy)
    %   obj = Graphics_source(target_axis,type,axis_lims,x,y)
    %   obj = Graphics_source(target_axis,type,axis_lims,x,y,e)
    %   
    %   Parameters
    %   target_axis         handle of the axis where data will be plotted
    %   type                either
    %                           'errorbar'
    %                           'line'
    %                           'bar'
    %                           'scatter'
    %   axis_lim            variable or function handle returning the axis
    %                       limits [xmin xmax ymin ymax]. If xmin and xmax
    %                       or ymin and ymax are both 0, their update mode
    %                       will be set to 'auto'.
    %   xy                  handle to a function with two output arguments
    %                       [x,y]
    %   x                   handle to x data (variable or function @()...)
    %   y                   handle to y data (variable or function @()...)
    %   e                   handle to e data (variable or function @()...)
    %
    %   For each plotted dataset it is enough to establish a
    %   Graphics_source instance and call the instance method update()
    %   whenever the plot needs to be refreshed.
    %
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        target_axis;
        
    end
    
    
    properties (Access = private)
        
        g_handle;
        axis_lims;
        xy;
        x;
        y;
        e;
        
    end
    
    methods (Access = public)
        
        function obj = Graphics_source(target_axis,type,a_lims,varargin)
            
            switch numel(varargin)
                
                case 1
                    
                    obj.xy = varargin{1};
                    obj.x = [];
                    obj.y = [];
                    obj.e = [];
   
                case 2
                    
                    obj.xy = [];
                    obj.x = varargin{1};
                    obj.y = varargin{2};
                    obj.e = [];
                    
                case 3
                    
                    obj.xy = [];
                    obj.x = varargin{1};
                    obj.y = varargin{2};
                    obj.e = varargin{3};
                    
                otherwise 
                    
                    error('Wrong number of input arguments.')
                          
            end % switch
            
            obj.target_axis = target_axis;
            axes(obj.target_axis);
            hold(obj.target_axis,'on');
            
            obj.axis_lims = a_lims;
            
            % recognize plot type -----------------------------------------
            
            p = [];
            
            switch type
                
                case 'errorbar'
                    
                    %p = @(x,y,e) errorbar(x,y,e,'Marker','o','LineStyle','none','Color','black');
                    p = @(x,y,e) errorbar(x,y,e,'Marker','o','LineStyle','none');
                   
                case 'line'
                    
                    p = @(x,y) line(x,y,'LineWidth',2);
                    
                case 'scatter'
                    
                    %p = @(x,y) scatter(x,y,'MarkerEdgeColor','black');
                    p = @(x,y) scatter(x,y);
                    
                case 'bar'
                    
                    p = @(x,y) bar(x,y,1,'LineStyle','none','FaceColor',[0 0.4470 0.7410]);
                    
                otherwise
                    
                    error('Plot type not recognized.');
                
            end % switch
            
            % recognize the data source type ------------------------------
            
            l = cellfun(@isempty, {obj.xy obj.x obj.y obj.e});
            
            if all([0 1 1 1] == l)  && nargin(p) == 2    % xy
                
                [xx,yy] = obj.xy();
                obj.g_handle = p(xx,yy);
                
            elseif all([1 0 0 1] == l) && nargin(p) == 2 % x,y
                
                xx = obj.x();
                yy = obj.y();
                obj.g_handle = p(xx,yy);
                
            elseif all([1 0 0 0] == l) && nargin(p) == 2 % x,y,e, but exclude e
                
                % error is included in the data, but we don't want to plot
                % it
                xx = obj.x();
                yy = obj.y();
                obj.g_handle = p(xx,yy);
                
            elseif all([1 0 0 0] == l) && nargin(p) == 3 % x,y,e
                
                xx = obj.x();
                yy = obj.y();
                ee = obj.e();
                obj.g_handle = p(xx,yy,ee);
                
            else
                
                error('Initialization error.');
                
            end % if
            
            % push the new object to the bottom
            %uistack(obj.g_handle,'bottom');
            
            % recognize the axis limit type -------------------------------
            
            % lims: [xmin xmax ymin ymax]
            lims = obj.axis_lims();
            
            l = lims == 0;
            
            if all(l)
                
                obj.target_axis.XLimMode = 'auto';
                obj.target_axis.YLimMode = 'auto';
                
            elseif all(l(1:2))
                
                obj.target_axis.XLimMode = 'auto';
                obj.target_axis.YLim = lims(3:end);
                
            elseif all(l(3:end))
                
                obj.target_axis.XLim = lims(1:2);
                obj.target_axis.YLimMode = 'auto';
                
            else
                
                obj.target_axis.XLim = lims(1:2);
                obj.target_axis.YLim = lims(3:end);
                
            end % if
            
            hold(obj.target_axis,'off');
            
        end % constructor
        
        set_grapho_properties(obj,varargin);
        update(obj);
        
        function delete(obj) 
            
            delete(obj.g_handle);
            
        end % delete
        
    end
    
end

