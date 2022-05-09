import * as React from "react";
import Link from "next/link";

export default function Footer() {
  return (
    <footer className="container mt-4 mx-auto text-xs">
      <nav className="flex flex-col md:flex-row mx-4 justify-between md:items-center border-t py-2">
        <Link href="/">
          <a className="order-last md:order-first border-t md:border-0">
            <img
              className="max-h-6 mr-1 inline"
              alt="PerfectRec logo"
              src="/images/icons/logo.svg"
            />
            <h4 className="text-lg text-black inline">
              <b>perfect</b>rec
            </h4>
            <p className="mt-2">
              &copy; PerfectRec, Inc. {new Date().getFullYear()}
            </p>
          </a>
        </Link>
        <div className="mb-2 md:mb-0">
          <ul>
            <li>Laptops</li>
            <li>TVs</li>
            <li>Smartphones</li>
          </ul>
        </div>
        <div className="mb-2 md:mb-0">
          <ul>
            <li>About</li>
            <li>Careers</li>
            <li>Values</li>
          </ul>
        </div>
      </nav>
    </footer>
  );
}
