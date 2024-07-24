use std::{fs::File, io::Write, path::PathBuf};

use anyhow::Error;

pub fn generate(out_dir: PathBuf, func_name: String, rep_count: usize) -> Result<(), Error> {
    let out_dir_fname = out_dir.to_str().unwrap();
    let wrapper_html = format!(
        r#"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${out_dir_fname}</title>
    <script type="module">
        async function test() {{
            let part;
            let imports = {{
                part: {{
                    '{func_name}': (...args) => {{
                        return part.instance.exports['{func_name}'](...args);
                    }},
                }}
            }};

            // Fetch and instantiate the rest of the module
            const restResponse = await fetch('./orig_rest.wasm');
            const restBinary = await restResponse.arrayBuffer();
            const rest = await WebAssembly.instantiate(restBinary, imports);

            // Fetch and instantiate the part module with imports from the rest module
            const partResponse = await fetch('./orig_part.wasm');
            const partBinary = await partResponse.arrayBuffer();
            let partImports = {{
                rest: rest.instance.exports
            }};
            part = await WebAssembly.instantiate(partBinary, partImports);

            // Call the main function to start the program
            const startTime = performance.now();
            for (let i = 0; i < {rep_count}; i++) {{
                rest.instance.exports.main();
            }}
            const endTime = performance.now();
            const executionTime = endTime - startTime;
            console.log(`Execution time: ${{executionTime}} milliseconds`);
            // Display the execution time at the DOM
            const executionTimeElement = document.createElement('p');
            executionTimeElement.textContent = `Execution time: ${{executionTime}} milliseconds`;
            document.body.appendChild(executionTimeElement);
    }}
        test();
    </script>
</head>
<body>
    <h1>${out_dir_fname}</h1>
</body>
</html>
"""#
    );
    let orig_html_path = out_dir.join("index.html");
    let mut orig_html_file = File::create(&orig_html_path)?;
    orig_html_file.write_all(wrapper_html.as_bytes())?;
    Ok(())
}
