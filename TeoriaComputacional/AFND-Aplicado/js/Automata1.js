class Automata1 {

	constructor(expression) {
		this.expression = expression.toUpperCase();
		this.state = {'state': 'q0', 'message': 'estado inicial'};
		this.counter;
	}

	getExpression() {
		return this.expression;
	}

	getState() {
		return this.state;
	}

	setState(state, message) {
		this.state['state'] = state;
		this.state['message'] = message;
	}

	start() {
		//Set character position and counter to zero
		this.position = 0;
		this.counter = 0;
		//Start at q0 
		this.q0(this.position);	
	}

	q0(position) {
		this.setState('q0', 'estado inicial');

		this.chr = this.expression.charAt(position);
		console.log(this.chr, this.state.state);


		if((this.chr === 'A' || this.chr === 'B')) {

			if(this.chr === 'A') {
				this.q3(position+1);
			}

			else if(this.chr === 'B') {
				this.q1(position+1);
			}				

			if(this.counter === 0) {
				this.q0(position+1);
			}
		}
		//Throw error if expression is not valid		
		else if(this.chr !== 'A' && this.chr !== 'B' && this.chr !== "") {
			this.n("m", "Cadena inválida");
		}


	}

	q1(position) {
		this.setState('q1', 'estado nivel 1');

		this.chr = this.expression.charAt(position);
		console.log(this.chr, this.state.state);

		this.counter = 1;
		if((this.chr === 'A' || this.chr === 'B')) {
			if(this.chr === 'B') {
				this.q2(position+1);
			}

			else if(this.chr === 'A') {
				this.counter = 0;
			}
		}

		//Throw error if expression is not valid
		else if(this.chr !== 'A' && this.chr !== 'B' && this.chr !== "") {
			this.n("m", "Cadena inválida");
		}

	}

	q2(position) {
		this.setState('q2', 'estado final');

		this.chr = this.expression.charAt(position);
		console.log(this.chr, this.state.state);

		this.counter = 2;

		//Check if is a valid expression
		if((this.chr === 'A' || this.chr === 'B')) {
			this.q2(position+1)
		}

		//Throw error if expression is not valid
		else if(this.chr !== 'A' && this.chr !== 'B' && this.chr !== "") {
			this.n("m", "Cadena inválida");
		}

	}

	q3(position) {
		this.setState('q3', 'estado nivel 1');

		this.chr = this.expression.charAt(position);
		console.log(this.chr, this.state.state);

		this.counter = 1;

		if((this.chr === 'A' || this.chr === 'B')) {
			if(this.chr === 'A') {
				this.q4(position+1);
			}

			else if(this.chr === 'B') {
				this.counter = 0;
			}
		}

		//Throw error if expression is not valid
		else if(this.chr !== 'A' && this.chr !== 'B' && this.chr !== "") {
			this.n("m", "Cadena inválida");
		}

	}

	q4(position) {
		this.setState('q4', 'estado final');

		this.chr = this.expression.charAt(position);
		console.log(this.chr, this.state.state);

		this.counter = 2;

		//Check if is a valid expression
		if((this.chr === 'A' || this.chr === 'B')) {
			this.q4(position+1)
		}

		//Throw error if expression is not valid
		else if(this.chr !== 'A' && this.chr !== 'B' && this.chr !== "") {
			this.n("m", "Cadena inválida");
		}

	}
	

	n(errortype, message) {
		this.setState(errortype, message);
	}

}