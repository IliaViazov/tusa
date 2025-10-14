import re
import sys

def extract_prompts_to_hs(input_file, output_file):
    with open(input_file, "r", encoding="utf-8") as f:
        lines = f.readlines()

    prompts = []
    found_superdirt = False

    for line in lines:
        if not found_superdirt:
            if "Connected to SuperDirt" in line:
                found_superdirt = True
            continue

        # Match lines like: d1 $ ..., d2 $ ..., etc.
        match = re.search(r'^\s*tidal>\s*(d\d+\s*\$.*)', line)
        if match:
            prompts.append(match.group(1).strip())

    # Write output with a blank line between prompts
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
