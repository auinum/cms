<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="https://fontlibrary.org/face/fantasque-sans-mono">
	<style>
		*,
		*::before,
		*::after {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			line-height: 1.75;
		}

		html {
			font-size: 16px;
			font-family: 'FantasqueSansMonoRegular';
		}

		html,
		body,
		main,
		section {
			width: 100%;
			height: 100%;
		}

		main,
		section {
			display: flex;
			justify-content: space-between;
			align-items: center;
		}

		main::before {
			order: 1;
			content: '';
			width: 100%;
			height: 100%;
			background-image:
				url('https://images.unsplash.com/photo-1586776977607-310e9c725c37');
			background-size: cover;
			background-position: center;
		}

		form {
			display: table;
			margin: auto;
		}

		label,
		input {
			width: 100%;
			display: block;
		}

		.field {
			display: flex;
			flex-wrap: wrap-reverse;
		}

		.field:not(:first-child) {
			margin-top: 1rem;
		}

		input {
			min-width: 15rem;
			border: none;
			border-bottom: 0.125rem solid;
			outline: none;
			font-size: 1rem;
			font-family: inherit;
		}

		button {
			min-width: 5rem;
			border: 0.25rem solid #00af96;
			background-color: transparent;
			font-size: 1rem;
			font-family: inherit;
			padding: 0.125rem 0;
			transition: all 0.5s;
		}

		button:hover {
			background-color: #00af96;
			color: #fff;
		}
	</style>
</head>

<body>
	<main>
		<section>
			<form action="/api/login/" method="post">
				<div class="field">
					<input type="text" name="username" id="username" placeholder="Username" required>
				</div>
				<div class="field">
					<input type="password" name="password" id="password" placeholder="Password" required>
				</div>
				<div class="field">
					<button type="submit">Login</button>
				</div>
			</form>
		</section>
	</main>

</body>

</html>