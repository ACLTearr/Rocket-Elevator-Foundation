require 'elevator_media'

#Weather for Montreal taken from https://weatherwidget.io/
weather = '<div> <a class="weatherwidget-io" href="https://forecast7.com/en/45d50n73d57/montreal/" data-label_1="MONTREAL" data-label_2="WEATHER" data-theme="original" >MONTREAL WEATHER</a>
<script>
!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://weatherwidget.io/js/widget.min.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","weatherwidget-io-js");
</script> </div>'

describe ElevatorMedia::Streamer do
    context 'test' do
        it 'tests working so far' do
            media = ElevatorMedia::Streamer.new
            expect(media). to be_kind_of(ElevatorMedia::Streamer)
        end
    end
    
    context 'Return weather' do
        it 'Returns weather into a div' do
            expect(ElevatorMedia::Streamer.getContent()).to eq(weather)
        end
    end
end