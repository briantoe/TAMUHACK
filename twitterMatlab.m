consumerkey = 'FaVG24EilMLhWvE4aVFZT2ag9';
consumersecret = 'cNRHs7GsP6UbgNU8Aa3x6d58ZFqvtfBjDE6DwzJRl8opiz2pdT';
accesstoken = '957326291543515136-bMc0bb2H6VrSBEOwC9bYn8asAWEUBge';
accesstokensecret = 'JgKtiW8qe107ImrTMSMtRAbseA0HQMrSpvmrTTGlCx9lX';
c = twitter(consumerkey,consumersecret,accesstoken,accesstokensecret);
searchThing='bakedpotatoes OR #potatoflower OR #nutforpotatoes OR #potatoes4lyf';
lib=query(1000,searchThing,c);
while(true)
    temp=query(100,searchThing,c);
    if(~isempty(lib))
        timeArray=lib(:).time;
        for i=length(temp):-1:1
            if(ismember(temp(i).time,timeArray))
                lib(length(lib)+1).time=temp(i).time;
                lib(length(lib)).location=temp(i).location;
            end
        end
    else
        for i=length(temp):-1:1
                lib(length(lib)+1).time=temp(i).time;
                lib(length(lib)).location=temp(i).location;
        end
    end
    output = struct('time','','longitude',0,'latitude',0);
    for i = 1:length(lib)
        output(i).time=lib(i).time;
        output(i).longitude=lib(i).location(1).coordinates(1);
        output(i).latitude=lib(i).location(1).coordinates(2);
    end
    struct2csv(output,'library.csv');
    pause(30);
end

function list = query(num,searchTerm,magic)
%parameters.count = num;
D=search(magic,searchTerm,'count',num);
statuss = D.Body.Data.statuses(:);
tempList(1).time='';
tempList(1).location=[];
for i = length(statuss):-1:1
    if(~isempty(statuss{i}.geo))
        tempList(length(tempList)+1).time=statuss{i}.created_at;
        tempList(length(tempList)).location=statuss{i}.coordinates;
    end
end
       tempList(1)=[];
       list=tempList;
end