%close all
%clear all

load('arc_matlab.mat');

% custom colormap:
colorMap = [0, 0, 0;
    0, 116, 217;
    255, 65, 54;
    46, 204, 64;
    255, 220, 0;
    170, 170, 170;
    240, 18, 190;
    255, 133, 27;
    127, 219, 255;
    135, 12, 37];
colorMap = colorMap / 255;


for probnum=[107] %, 53, 73, 95, 136, 220, 230, 282, 317, 331]
%for probnum=[15, 53, 73, 95, 136, 220, 230, 282, 317, 331]

    Kj=[];     Kj=[]; %to avoid crossover of rules between different problems.

    kjmax=length(arc(probnum).train)+length(arc(probnum).test); %Look at both train and test (kjt below will prevent learning rules from test).
    figure('Name',['Problem ',num2str(probnum),' Matrix Heuristics'],'Position',[100 800 400 kjmax*100]);
    figmh=gcf; axmh=gca; colormap(colorMap); 
        %Code for selecting subplots
    imrowleng=3; %Number of plots in each row for each example kj.
    numplots=imrowleng*kjmax;
    h=zeros(1,numplots);
    for k=1:numplots %number of subplots
        h(k)=subplot(kjmax,imrowleng,k);
    end
    %&&&&&&&&&&&&&&&&&&&&&&&&&
    %LOAD THE EXAMPLES.
    %&&&&&&&&&&&&&&&&&&&&&&&&&
    for kj=1:length(arc(probnum).train)  %LOAD the training examples and test examples at start. Then stop loop before training.
     
            Kj(kj).Rm=[]; %To avoid crashes due to non-existent struct
            
            %LOAD THE ELEMENTS OF THIS EXAMPLE - eventually merge train and test.
            if kj<=length(arc(probnum).train); %Load the train examples
                Kj(kj).inputw=arc(probnum).train(kj).input;
                Kj(kj).outputw=arc(probnum).train(kj).output;

            end
            
           % Kj(kj).diffsub=Kj(kj).outputw-Kj(kj).inputw; %subtraction to make diffsub

            %DEFINE WORLD SIZE 
            Kj(kj).insz=size(Kj(kj).inputw);
            Kj(kj).outsz=size(Kj(kj).outputw);
            
            %if max(max(Kj(kj).diffsub))<=0; Kj(kj).diffsub=-Kj(kj).diffsub; end; %If diffsub values are all negative flip them to see them.
            
            %if Kj(kj).insz==Kj(kj).outsz;
            %    Kj(kj).diffsize=Kj(kj).insz;
            %elseif Kj(kj).insz(1,1)>Kj(kj).outsz(1,1);
            %    Kj(kj).diffsize=Kj(kj).insz;
            %elseif Kj(kj).outsz(1,1)>Kj(kj).insz(1,1);
            %    Kj(kj).diffsize=Kj(kj).outsz;
            %end
            
            %Show the input and output and subtraction 
            showexamples=1;
            if showexamples==1;
                if kj<=length(arc(probnum).train) %only show the training examples at start
%             axes(h((kj-1)*imrowleng+1)); %Image the input in column 1
%             image(inputw+1);
%             axes(h((kj-1)*imrowleng+2)); %Image the output in column 2.
%             image(Kj(kj).outputw+1);
%             axes(h((kj-1)*imrowleng+3)); %Show the subtraction in column 3 with input and output.
%             image(diffsub+1);
                    axes(h((kj-1)*imrowleng+1)) %Plot input in column 6 next to the rule agent image in column 7
                    image(Kj(kj).inputw+1);
                    axes(h((kj-1)*imrowleng+3))
                    image(Kj(kj).outputw+1); %Show the target output in column 8 next to the rule agent image in column 7.
                    drawnow
                end %if kj<
            end
        end %end for kj=1:kjmax.  END of kj loop for LOADING inputw and outputw
        
        %Now load ONLY the test input and insize
        kjtest=length(arc(probnum).train)+length(arc(probnum).test);
        Kj(kjtest).inputw=arc(probnum).test(1).input;
        Kj(kjtest).insz=size(Kj(kjtest).inputw);
                        
        axes(h((kjtest-1)*imrowleng+1)) %Show the test problem only on last mm cycle
        image(Kj(kjtest).inputw+1);
        drawnow

end
