import re
import sys

def extract_prompts_to_hs(input_file, output_file):
    with open(input_file, "r", encoding="utf-8") as f:
        lines = f.readlines()

    prompts = []
    found_superdirt = False
    current_prompt = None
    skip_until_next_prompt = False  # flag for skipping GHC output

    for line in lines:
        # Ignore everything until SuperDirt is connected
        if not found_superdirt:
            if "Connected to SuperDirt" in line:
                found_superdirt = True
            continue

        # If we're skipping due to an <interactive> error, ignore until next tidal>
        if skip_until_next_prompt:
            if line.startswith("tidal>"):
                skip_until_next_prompt = False  # stop skipping
                # Save previous (if any) and start new prompt
                if current_prompt:
                    prompts.append(current_prompt.strip())
                current_prompt = re.match(r'^tidal>\s*(.*)', line).group(1).rstrip()
            # otherwise continue skipping
            continue

        # Detect new prompt start
        m = re.match(r'^tidal>\s*(.*)', line)
        if m:
            # Save previous prompt, if any
            if current_prompt:
                prompts.append(current_prompt.strip())
            # Start new prompt
            current_prompt = m.group(1).rstrip()
            continue

        # If an <interactive> appears, drop current prompt and skip until next tidal>
        if "<interactive>" in line:
            current_prompt = None
            skip_until_next_prompt = True
            continue

        # Otherwise, append continuation line
        if current_prompt is not None:
            current_prompt += " " + line.strip()

    # Add the last collected prompt, if any
    if current_prompt:
        prompts.append(current_prompt.strip())

    # Write output file
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("-- Extracted TidalCycles prompts\n\n")
        for p in prompts:
            f.write(p + "\n\n")

    print(f"Extracted {len(prompts)} prompts to {output_file}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 extract_tidal_prompts.py input.txt output.hs")
        sys.exit(1)

    extract_prompts_to_hs(sys.argv[1], sys.argv[2])
