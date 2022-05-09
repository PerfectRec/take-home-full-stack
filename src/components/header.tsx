import Link from "next/link";

export default function Header(props) {
  return (
    <header className="container mx-auto">
      <nav className="flex mx-4 justify-between items-center border-b py-2">
        <Link href="/">
          <a data-testid="header-logo">
            <img
              className="max-h-6 mr-1 inline"
              alt="PerfectRec logo"
              src="/images/icons/logo.svg"
            />
            <h1 className="text-lg text-black inline">
              <b>perfect</b>rec
            </h1>
          </a>
        </Link>
      </nav>
    </header>
  );
}
