function startupFcn(app)
            %Give resolution for your previous screen:
            old_screen=[1920,1080];
            %Collect information about new screen:
            set(0,'units','pixels');
            Pix_SS = get(0,'screensize');
            %Assign coefficient of reduction/increase:
            k_hor=Pix_SS(3)/old_screen(1);
            k_vert=Pix_SS(4)/old_screen(2);
            %Get size of your original application UI:
            uisize = app.UIFigure.Position;
            screenWidth = uisize(3);
            screenHeight = uisize(4);
            left = uisize(1);
            bottom = uisize(2);
            %Assign new size for the width and height:
            width = screenWidth*k_hor;
            height = screenHeight*k_vert;
            %Assign coefficient to reduce font sizes:
            k_font=(k_hor+k_vert)/2;
            drawnow;
            %Collect UI elements:
            comp=app.UIFigure.Children;
            %Change UI element size to new scaled size:
            app.UIFigure.Position = [left bottom width height];
            %Change locations, width, height, and font of each element:
            for i=1:numel(comp)
                app.UIFigure.Children(i).Position(3)=comp(i).Position(3)*k_hor;
                app.UIFigure.Children(i).Position(4)=comp(i).Position(4)*k_vert;
                app.UIFigure.Children(i).Position(1)=comp(i).Position(1)*k_hor;
                app.UIFigure.Children(i).Position(2)=comp(i).Position(2)*k_vert;
                %Catch an error for possible UI elements not having FontSize
                    try
                    a{i} = comp(i).FontSize;
                    catch
                    warning('This object does not have font option.  Assigning a value of 0.');
                    a{i} = 0;
                    end
                    %CHange FontSize of all elements that actually have
                    %FontSize component
                if a{i}~=0
                app.UIFigure.Children(i).FontSize=comp(i).FontSize*k_font;
                end
            end
end