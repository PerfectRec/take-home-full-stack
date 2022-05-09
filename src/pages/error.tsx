export default function Error() {
  let message = "";

  if (typeof window !== "undefined") {
    const urlSearchParams = new URLSearchParams(window.location.search);
    message = urlSearchParams.get("message") || "An unexpected error occurred";
  }

  return (
    <div className="flex items-start min-h-[85vh] mx-auto p-4">
      <h1>Error</h1>
    </div>
  );
}
