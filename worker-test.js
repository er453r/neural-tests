function workerBody() {
	console.log('started!');

	onmessage = function (event) {
		var n = event.data.id;

		console.log('id = ' + event.data.id);

		var sab = event.data.sab;

		var ia = new Int32Array(sab);

		ia[n] = n + 3;
	};
}

document.addEventListener("DOMContentLoaded", function(){
	console.log("ready!");
	
	var url = window.URL.createObjectURL(new Blob(['(', workerBody.toString(), ')()'],{type:'text/javascript'}));

	var threads = 5;

	var workers = [];

	var sab = new SharedArrayBuffer(Int32Array.BYTES_PER_ELEMENT * threads);
	var ia = new Int32Array(sab);

	console.dir(ia);

	for(var n  = 0; n < threads; n++){
		var worker = new Worker(url);

		worker.postMessage({id: n, sab: sab}, [sab]);

		workers.push(workers);
	}

	setTimeout(function () {
		console.dir(ia);
	}, 2000);
});
