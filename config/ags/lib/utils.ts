export async function sh(cmd: string | string[]) {
  return Utils.execAsync(cmd).catch((err) => {
    console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err);
    return "";
  });
}

export function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
