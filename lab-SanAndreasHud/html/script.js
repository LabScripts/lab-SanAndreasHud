let bars = {}


$(function () {
	window.addEventListener('message', function (event) {
		let data = event.data.data;
		if (event.data.action == 'show') {
			$('#wrap').show();
			ConstractDOM();
		}
		else if (event.data.action == 'hide') {
			$('#wrap').hide();
		}
		else if (event.data.action == 'updateClock') {
			$( "#hours" ).text(event.data.hours);
			$( "#minutes" ).text(event.data.minutes);
		}
		else if (event.data.action == 'updateHealth') {
			bars.kot.animate(event.data.current/event.data.max)
			$( "#my-health" ).text(event.data.current);
		}
		else if (event.data.action == 'updateArmor') {
			bars.kot2.animate(event.data.current/event.data.max)
		}
		else if (event.data.action == 'updateHunger') {
			bars.kot3.animate(event.data.current/event.data.max)
			if (event.data.current == 0) {
				$( "#kotbar3" ).css('animation','1s blink ease infinite');
			} else {
				$( "#kotbar3" ).css('animation','none');
			}
		}
		else if (event.data.action == 'updateThirst') {
			bars.kot4.animate(event.data.current/event.data.max)
			if (event.data.current == 0) {
				$( "#kotbar4" ).css('animation','1s blink ease infinite');
			} else {
				$( "#kotbar4" ).css('animation','none');
			}
		}
		else if (event.data.action == 'updateStatus') {
			$( ".job" ).text(event.data.job);
			$( "#money" ).text(event.data.bank);
		}
		else if (event.data.action == 'setWeaponImg'){
			$("#weapon").attr("src","images/WEAPONS/" + event.data.weapon + ".png");
			if (event.data.ammo) {
				$('#ammo').show();
				$( "#ammo" ).text(event.data.ammo);
			}else {
				$('#ammo').hide();
			}
		}
	});
});

function UpdateLevel(level, bar_xp, bar_xp_next) {
	$("#level-img").attr("src","images/levels/" + level + ".png");
	$( "#my-level" ).text(level);
	$( "#my-xp" ).text(bar_xp);
	$( "#next-xp" ).text(bar_xp_next);
	bars.level.animate(bar_xp/bar_xp_next)
}

function GetElementByType(type){
	if (NameToElementId[type]){
		return $('#'+NameToElementId[type])
	}
	else{
		return $('#'+type)
	}
}


document.addEventListener('DOMContentLoaded', function() {
	// Initialise progressbars
	bars.kot = CreateProgBar('#progbar',"");
	bars.kot2 = CreateProgBar2('#progbar2',"");
	bars.kot3 = CreateProgBar3('#progbar3',"");
	bars.kot4 = CreateProgBar4('#progbar4',"");
	
	bars.kot.animate(0/100)
	bars.kot2.animate(0/100)
	bars.kot3.animate(0/100)
	bars.kot4.animate(0/100)
}, false);

function CreateProgBar(element,img){
	let bar = new ProgressBar.Line(element, {
		strokeWidth: 1,
		strokeStyle: '#df0000',
		fill: '#df0000',
		trailColor: '#850000',
		trailWidth: 1,
		easing: 'easeInOut',
		duration: 2000,
		svgStyle: null,
		text: {
		  value: '',
		  alignToBottom: false
		},
		
		// Set default step function for all animate calls
		step: (state, bar) => {
		  bar.path.setAttribute('stroke', state.color);
		  bar.setText(img);
		  bar.text.style.color = state.color;
		}
	});
	return bar;
}

function CreateProgBar2(element,img){
	let bar = new ProgressBar.Line(element, {
		strokeWidth: 1,
		strokeStyle: 'rgba(255,255,255,1)',
		fill: 'rgba(0,0,0,0.2)',
		trailColor: '#899292',
		trailWidth: 1,
		easing: 'easeInOut',
		duration: 2000,
		svgStyle: null,
		text: {
		  value: '',
		  alignToBottom: false
		},
		
		// Set default step function for all animate calls
		step: (state, bar) => {
		  bar.path.setAttribute('stroke', state.color);
		  bar.setText(img);
		  bar.text.style.color = state.color;
		}
	});
	return bar;
}

function CreateProgBar3(element,img){
	let bar = new ProgressBar.Line(element, {
		strokeWidth: 1,
		strokeStyle: 'rgba(255,255,255,1)',
		fill: 'rgba(0,0,0,0.2)',
		trailColor: '#894e14',
		trailWidth: 1,
		easing: 'easeInOut',
		duration: 2000,
		svgStyle: null,
		text: {
		  value: '',
		  alignToBottom: false
		},
		
		// Set default step function for all animate calls
		step: (state, bar) => {
		  bar.path.setAttribute('stroke', state.color);
		  bar.setText(img);
		  bar.text.style.color = state.color;
		}
	});
	return bar;
}

function CreateProgBar4(element,img){
	let bar = new ProgressBar.Line(element, {
		strokeWidth: 1,
		strokeStyle: 'rgba(255,255,255,1)',
		fill: 'rgba(0,0,0,0.2)',
		trailColor: '#1e4381',
		trailWidth: 1,
		easing: 'easeInOut',
		duration: 2000,
		svgStyle: null,
		text: {
		  value: '',
		  alignToBottom: false
		},
		
		// Set default step function for all animate calls
		step: (state, bar) => {
		  bar.path.setAttribute('stroke', state.color);
		  bar.setText(img);
		  bar.text.style.color = state.color;
		}
	});
	return bar;
}