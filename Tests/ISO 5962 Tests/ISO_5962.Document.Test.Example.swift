// Transliterated from the SPDX 2.2.1 JSON example (spdx/spdx-spec v2.2.1, examples/SPDXJSONExample-v2.2.spdx.json), CC-BY-3.0.
import ISO_5962
import ISO_5962_License_Expression
import RFC_8259

extension ISO_5962.Document.Test {
    enum Example {}
}

extension ISO_5962.Document.Test.Example {
    static let document: RFC_8259.Value = .object(
        RFC_8259.Object([
            ("SPDXID", .string("SPDXRef-DOCUMENT")),
            ("spdxVersion", .string("SPDX-2.2")),
            (
                "creationInfo",
                .object(
                    RFC_8259.Object([
                        (
                            "comment",
                            .string("This package has been shipped in source and binary form.\nThe binaries were created with gcc 4.5.1 and expect to link to\ncompatible system run time libraries.")
                        ),
                        ("created", .string("2010-01-29T18:30:22Z")),
                        (
                            "creators",
                            .array(
                                RFC_8259.Array([
                                    .string("Tool: LicenseFind-1.0"),
                                    .string("Organization: ExampleCodeInspect ()"),
                                    .string("Person: Jane Doe ()"),
                                ])
                            )
                        ),
                        ("licenseListVersion", .string("3.9")),
                    ])
                )
            ),
            ("name", .string("SPDX-Tools-v2.0")),
            ("dataLicense", .string("CC0-1.0")),
            ("comment", .string("This document was created using SPDX 2.0 using licenses from the web site.")),
            (
                "externalDocumentRefs",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("externalDocumentId", .string("DocumentRef-spdx-tool-1.2")),
                                (
                                    "checksum",
                                    .object(
                                        RFC_8259.Object([
                                            ("algorithm", .string("SHA1")),
                                            ("checksumValue", .string("d6a770ba38583ed4bb4525bd96e50461655d2759")),
                                        ])
                                    )
                                ),
                                ("spdxDocument", .string("http://spdx.org/spdxdocs/spdx-tools-v1.2-3F2504E0-4F89-41D3-9A0C-0305E82C3301")),
                            ])
                        )
                    ])
                )
            ),
            (
                "hasExtractedLicensingInfos",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("licenseId", .string("LicenseRef-1")),
                                (
                                    "extractedText",
                                    .string(
                                        "/*\n * (c) Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Hewlett-Packard Development Company, LP\n * All rights reserved.\n *\n * Redistribution and use in source and binary forms, with or without\n * modification, are permitted provided that the following conditions\n * are met:\n * 1. Redistributions of source code must retain the above copyright\n *    notice, this list of conditions and the following disclaimer.\n * 2. Redistributions in binary form must reproduce the above copyright\n *    notice, this list of conditions and the following disclaimer in the\n *    documentation and/or other materials provided with the distribution.\n * 3. The name of the author may not be used to endorse or promote products\n *    derived from this software without specific prior written permission.\n *\n * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR\n * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES\n * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.\n * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,\n * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT\n * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF\n * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n*/"
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("licenseId", .string("LicenseRef-2")),
                                (
                                    "extractedText",
                                    .string(
                                        "This package includes the GRDDL parser developed by Hewlett Packard under the following license:\n� Copyright 2007 Hewlett-Packard Development Company, LP\n\nRedistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met: \n\nRedistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. \nRedistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. \nThe name of the author may not be used to endorse or promote products derived from this software without specific prior written permission. \nTHIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("licenseId", .string("LicenseRef-4")),
                                (
                                    "extractedText",
                                    .string(
                                        "/*\n * (c) Copyright 2009 University of Bristol\n * All rights reserved.\n *\n * Redistribution and use in source and binary forms, with or without\n * modification, are permitted provided that the following conditions\n * are met:\n * 1. Redistributions of source code must retain the above copyright\n *    notice, this list of conditions and the following disclaimer.\n * 2. Redistributions in binary form must reproduce the above copyright\n *    notice, this list of conditions and the following disclaimer in the\n *    documentation and/or other materials provided with the distribution.\n * 3. The name of the author may not be used to endorse or promote products\n *    derived from this software without specific prior written permission.\n *\n * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR\n * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES\n * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.\n * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,\n * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT\n * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF\n * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n*/"
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("licenseId", .string("LicenseRef-Beerware-4.2")),
                                ("comment", .string("The beerware license has a couple of other standard variants.")),
                                (
                                    "extractedText",
                                    .string(
                                        "\"THE BEER-WARE LICENSE\" (Revision 42):\nphk@FreeBSD.ORG wrote this file. As long as you retain this notice you\ncan do whatever you want with this stuff. If we meet some day, and you think this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp"
                                    )
                                ),
                                ("name", .string("Beer-Ware License (Version 42)")),
                                (
                                    "seeAlsos",
                                    .array(
                                        RFC_8259.Array([
                                            .string("http://people.freebsd.org/~phk/")
                                        ])
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("licenseId", .string("LicenseRef-3")),
                                ("comment", .string("This is tye CyperNeko License")),
                                (
                                    "extractedText",
                                    .string(
                                        "The CyberNeko Software License, Version 1.0\n\n \n(C) Copyright 2002-2005, Andy Clark.  All rights reserved.\n \nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions\nare met:\n\n1. Redistributions of source code must retain the above copyright\n   notice, this list of conditions and the following disclaimer. \n\n2. Redistributions in binary form must reproduce the above copyright\n   notice, this list of conditions and the following disclaimer in\n   the documentation and/or other materials provided with the\n   distribution.\n\n3. The end-user documentation included with the redistribution,\n   if any, must include the following acknowledgment:  \n     \"This product includes software developed by Andy Clark.\"\n   Alternately, this acknowledgment may appear in the software itself,\n   if and wherever such third-party acknowledgments normally appear.\n\n4. The names \"CyberNeko\" and \"NekoHTML\" must not be used to endorse\n   or promote products derived from this software without prior \n   written permission. For written permission, please contact \n   andyc@cyberneko.net.\n\n5. Products derived from this software may not be called \"CyberNeko\",\n   nor may \"CyberNeko\" appear in their name, without prior written\n   permission of the author.\n\nTHIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED\nWARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES\nOF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\nDISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR OTHER CONTRIBUTORS\nBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, \nOR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT \nOF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR \nBUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, \nWHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE \nOR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, \nEVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
                                    )
                                ),
                                ("name", .string("CyberNeko License")),
                                (
                                    "seeAlsos",
                                    .array(
                                        RFC_8259.Array([
                                            .string("http://people.apache.org/~andyc/neko/LICENSE"),
                                            .string("http://justasample.url.com"),
                                        ])
                                    )
                                ),
                            ])
                        ),
                    ])
                )
            ),
            (
                "annotations",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("annotationDate", .string("2010-01-29T18:30:22Z")),
                                ("annotationType", .string("OTHER")),
                                ("annotator", .string("Person: Jane Doe ()")),
                                ("comment", .string("Document level annotation")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("annotationDate", .string("2010-02-10T00:00:00Z")),
                                ("annotationType", .string("REVIEW")),
                                ("annotator", .string("Person: Joe Reviewer")),
                                ("comment", .string("This is just an example.  Some of the non-standard licenses look like they are actually BSD 3 clause licenses")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("annotationDate", .string("2011-03-13T00:00:00Z")),
                                ("annotationType", .string("REVIEW")),
                                ("annotator", .string("Person: Suzanne Reviewer")),
                                ("comment", .string("Another example reviewer.")),
                            ])
                        ),
                    ])
                )
            ),
            ("documentNamespace", .string("http://spdx.org/spdxdocs/spdx-example-444504E0-4F89-41D3-9A0C-0305E82C3301")),
            (
                "documentDescribes",
                .array(
                    RFC_8259.Array([
                        .string("SPDXRef-File"),
                        .string("SPDXRef-Package"),
                    ])
                )
            ),
            (
                "packages",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-Package")),
                                (
                                    "annotations",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("annotationDate", .string("2011-01-29T18:30:22Z")),
                                                    ("annotationType", .string("OTHER")),
                                                    ("annotator", .string("Person: Package Commenter")),
                                                    ("comment", .string("Package level annotation")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                (
                                    "attributionTexts",
                                    .array(
                                        RFC_8259.Array([
                                            .string(
                                                "The GNU C Library is free software.  See the file COPYING.LIB for copying conditions, and LICENSES for notices about a few contributions that require these additional notices to be distributed.  License copyright years may be listed using range notation, e.g., 1996-2015, indicating that every year in the range, inclusive, is a copyrightable year that would otherwise be listed individually."
                                            )
                                        ])
                                    )
                                ),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("MD5")),
                                                    ("checksumValue", .string("624c1abb3664f4b35547e7c73864ad24")),
                                                ])
                                            ),
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("85ed0817af83a24ad8da68c2b5094de69833983c")),
                                                ])
                                            ),
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA256")),
                                                    ("checksumValue", .string("11b6d3ee554eedf79299905a98f9b9a04e498210b59f15094c916c91d150efcd")),
                                                ])
                                            ),
                                        ])
                                    )
                                ),
                                ("copyrightText", .string("Copyright 2008-2010 John Smith")),
                                (
                                    "description",
                                    .string(
                                        "The GNU C Library defines functions that are specified by the ISO C standard, as well as additional features specific to POSIX and other derivatives of the Unix operating system, and extensions specific to GNU systems."
                                    )
                                ),
                                ("downloadLocation", .string("http://ftp.gnu.org/gnu/glibc/glibc-ports-2.15.tar.gz")),
                                (
                                    "externalRefs",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("referenceCategory", .string("SECURITY")),
                                                    ("referenceLocator", .string("cpe:2.3:a:pivotal_software:spring_framework:4.1.0:*:*:*:*:*:*:*")),
                                                    ("referenceType", .string("cpe23Type")),
                                                ])
                                            ),
                                            .object(
                                                RFC_8259.Object([
                                                    ("comment", .string("This is the external ref for Acme")),
                                                    ("referenceCategory", .string("OTHER")),
                                                    ("referenceLocator", .string("acmecorp/acmenator/4.1.3-alpha")),
                                                    ("referenceType", .string("http://spdx.org/spdxdocs/spdx-example-444504E0-4F89-41D3-9A0C-0305E82C3301#LocationRef-acmeforge")),
                                                ])
                                            ),
                                        ])
                                    )
                                ),
                                ("filesAnalyzed", .bool(true)),
                                (
                                    "hasFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("SPDXRef-CommonsLangSrc"),
                                            .string("SPDXRef-JenaLib"),
                                            .string("SPDXRef-DoapSource"),
                                        ])
                                    )
                                ),
                                ("homepage", .string("http://ftp.gnu.org/gnu/glibc")),
                                (
                                    "licenseComments",
                                    .string("The license for this project changed with the release of version x.y.  The version of the project included here post-dates the license change.")
                                ),
                                ("licenseConcluded", .string("(LGPL-2.0-only OR LicenseRef-3)")),
                                ("licenseDeclared", .string("(LGPL-2.0-only AND LicenseRef-3)")),
                                (
                                    "licenseInfoFromFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("GPL-2.0-only"),
                                            .string("LicenseRef-2"),
                                            .string("LicenseRef-1"),
                                        ])
                                    )
                                ),
                                ("name", .string("glibc")),
                                ("originator", .string("Organization: ExampleCodeInspect (contact@example.com)")),
                                ("packageFileName", .string("glibc-2.11.1.tar.gz")),
                                (
                                    "packageVerificationCode",
                                    .object(
                                        RFC_8259.Object([
                                            (
                                                "packageVerificationCodeExcludedFiles",
                                                .array(
                                                    RFC_8259.Array([
                                                        .string("./package.spdx")
                                                    ])
                                                )
                                            ),
                                            ("packageVerificationCodeValue", .string("d6a770ba38583ed4bb4525bd96e50461655d2758")),
                                        ])
                                    )
                                ),
                                ("sourceInfo", .string("uses glibc-2_11-branch from git://sourceware.org/git/glibc.git.")),
                                ("summary", .string("GNU C library.")),
                                ("supplier", .string("Person: Jane Doe (jane.doe@example.com)")),
                                ("versionInfo", .string("2.11.1")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-fromDoap-1")),
                                ("copyrightText", .string("NOASSERTION")),
                                ("downloadLocation", .string("NOASSERTION")),
                                ("filesAnalyzed", .bool(false)),
                                ("homepage", .string("http://commons.apache.org/proper/commons-lang/")),
                                ("licenseConcluded", .string("NOASSERTION")),
                                ("licenseDeclared", .string("NOASSERTION")),
                                ("name", .string("Apache Commons Lang")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-fromDoap-0")),
                                ("copyrightText", .string("NOASSERTION")),
                                ("downloadLocation", .string("https://search.maven.org/remotecontent?filepath=org/apache/jena/apache-jena/3.12.0/apache-jena-3.12.0.tar.gz")),
                                (
                                    "externalRefs",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("referenceCategory", .string("PACKAGE_MANAGER")),
                                                    ("referenceLocator", .string("pkg:maven/org.apache.jena/apache-jena@3.12.0")),
                                                    ("referenceType", .string("purl")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                ("filesAnalyzed", .bool(false)),
                                ("homepage", .string("http://www.openjena.org/")),
                                ("licenseConcluded", .string("NOASSERTION")),
                                ("licenseDeclared", .string("NOASSERTION")),
                                ("name", .string("Jena")),
                                ("versionInfo", .string("3.12.0")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-Saxon")),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("85ed0817af83a24ad8da68c2b5094de69833983c")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                ("copyrightText", .string("Copyright Saxonica Ltd")),
                                ("description", .string("The Saxon package is a collection of tools for processing XML documents.")),
                                ("downloadLocation", .string("https://sourceforge.net/projects/saxon/files/Saxon-B/8.8.0.7/saxonb8-8-0-7j.zip/download")),
                                ("filesAnalyzed", .bool(false)),
                                ("homepage", .string("http://saxon.sourceforge.net/")),
                                ("licenseComments", .string("Other versions available for a commercial license")),
                                ("licenseConcluded", .string("MPL-1.0")),
                                ("licenseDeclared", .string("MPL-1.0")),
                                ("name", .string("Saxon")),
                                ("packageFileName", .string("saxonB-8.8.zip")),
                                ("versionInfo", .string("8.8")),
                            ])
                        ),
                    ])
                )
            ),
            (
                "files",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-DoapSource")),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("2fd4e1c67a2d28fced849ee1bb76e7391b93eb12")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                ("copyrightText", .string("Copyright 2010, 2011 Source Auditor Inc.")),
                                (
                                    "fileContributors",
                                    .array(
                                        RFC_8259.Array([
                                            .string("Protecode Inc."),
                                            .string("SPDX Technical Team Members"),
                                            .string("Open Logic Inc."),
                                            .string("Source Auditor Inc."),
                                            .string("Black Duck Software In.c"),
                                        ])
                                    )
                                ),
                                ("fileName", .string("./src/org/spdx/parser/DOAPProject.java")),
                                (
                                    "fileTypes",
                                    .array(
                                        RFC_8259.Array([
                                            .string("SOURCE")
                                        ])
                                    )
                                ),
                                ("licenseConcluded", .string("Apache-2.0")),
                                (
                                    "licenseInfoInFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("Apache-2.0")
                                        ])
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-CommonsLangSrc")),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("c2b4e1c67a2d28fced849ee1bb76e7391b93f125")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                ("comment", .string("This file is used by Jena")),
                                ("copyrightText", .string("Copyright 2001-2011 The Apache Software Foundation")),
                                (
                                    "fileContributors",
                                    .array(
                                        RFC_8259.Array([
                                            .string("Apache Software Foundation")
                                        ])
                                    )
                                ),
                                ("fileName", .string("./lib-source/commons-lang3-3.1-sources.jar")),
                                (
                                    "fileTypes",
                                    .array(
                                        RFC_8259.Array([
                                            .string("ARCHIVE")
                                        ])
                                    )
                                ),
                                ("licenseConcluded", .string("Apache-2.0")),
                                (
                                    "licenseInfoInFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("Apache-2.0")
                                        ])
                                    )
                                ),
                                (
                                    "noticeText",
                                    .string(
                                        "Apache Commons Lang\nCopyright 2001-2011 The Apache Software Foundation\n\nThis product includes software developed by\nThe Apache Software Foundation (http://www.apache.org/).\n\nThis product includes software from the Spring Framework,\nunder the Apache License 2.0 (see: StringUtils.containsWhitespace())"
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-JenaLib")),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("3ab4e1c67a2d28fced849ee1bb76e7391b93f125")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                ("comment", .string("This file belongs to Jena")),
                                ("copyrightText", .string("(c) Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Hewlett-Packard Development Company, LP")),
                                (
                                    "fileContributors",
                                    .array(
                                        RFC_8259.Array([
                                            .string("Apache Software Foundation"),
                                            .string("Hewlett Packard Inc."),
                                        ])
                                    )
                                ),
                                ("fileName", .string("./lib-source/jena-2.6.3-sources.jar")),
                                (
                                    "fileTypes",
                                    .array(
                                        RFC_8259.Array([
                                            .string("ARCHIVE")
                                        ])
                                    )
                                ),
                                ("licenseComments", .string("This license is used by Jena")),
                                ("licenseConcluded", .string("LicenseRef-1")),
                                (
                                    "licenseInfoInFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("LicenseRef-1")
                                        ])
                                    )
                                ),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-File")),
                                (
                                    "annotations",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("annotationDate", .string("2011-01-29T18:30:22Z")),
                                                    ("annotationType", .string("OTHER")),
                                                    ("annotator", .string("Person: File Commenter")),
                                                    ("comment", .string("File level annotation")),
                                                ])
                                            )
                                        ])
                                    )
                                ),
                                (
                                    "checksums",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("SHA1")),
                                                    ("checksumValue", .string("d6a770ba38583ed4bb4525bd96e50461655d2758")),
                                                ])
                                            ),
                                            .object(
                                                RFC_8259.Object([
                                                    ("algorithm", .string("MD5")),
                                                    ("checksumValue", .string("624c1abb3664f4b35547e7c73864ad24")),
                                                ])
                                            ),
                                        ])
                                    )
                                ),
                                (
                                    "comment",
                                    .string(
                                        "The concluded license was taken from the package level that the file was included in.\nThis information was found in the COPYING.txt file in the xyz directory."
                                    )
                                ),
                                ("copyrightText", .string("Copyright 2008-2010 John Smith")),
                                (
                                    "fileContributors",
                                    .array(
                                        RFC_8259.Array([
                                            .string("The Regents of the University of California"),
                                            .string("Modified by Paul Mundt lethal@linux-sh.org"),
                                            .string("IBM Corporation"),
                                        ])
                                    )
                                ),
                                ("fileName", .string("./package/foo.c")),
                                (
                                    "fileTypes",
                                    .array(
                                        RFC_8259.Array([
                                            .string("SOURCE")
                                        ])
                                    )
                                ),
                                ("licenseComments", .string("The concluded license was taken from the package level that the file was included in.")),
                                ("licenseConcluded", .string("(LGPL-2.0-only OR LicenseRef-2)")),
                                (
                                    "licenseInfoInFiles",
                                    .array(
                                        RFC_8259.Array([
                                            .string("GPL-2.0-only"),
                                            .string("LicenseRef-2"),
                                        ])
                                    )
                                ),
                                (
                                    "noticeText",
                                    .string(
                                        "Copyright (c) 2001 Aaron Lehmann aaroni@vitelus.com\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the �Software�), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED �AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
                                    )
                                ),
                            ])
                        ),
                    ])
                )
            ),
            (
                "snippets",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("SPDXID", .string("SPDXRef-Snippet")),
                                (
                                    "comment",
                                    .string(
                                        "This snippet was identified as significant and highlighted in this Apache-2.0 file, when a commercial scanner identified it as being derived from file foo.c in package xyz which is licensed under GPL-2.0."
                                    )
                                ),
                                ("copyrightText", .string("Copyright 2008-2010 John Smith")),
                                (
                                    "licenseComments",
                                    .string(
                                        "The concluded license was taken from package xyz, from which the snippet was copied into the current file. The concluded license information was found in the COPYING.txt file in package xyz."
                                    )
                                ),
                                ("licenseConcluded", .string("GPL-2.0-only")),
                                (
                                    "licenseInfoInSnippets",
                                    .array(
                                        RFC_8259.Array([
                                            .string("GPL-2.0-only")
                                        ])
                                    )
                                ),
                                ("name", .string("from linux kernel")),
                                (
                                    "ranges",
                                    .array(
                                        RFC_8259.Array([
                                            .object(
                                                RFC_8259.Object([
                                                    (
                                                        "endPointer",
                                                        .object(
                                                            RFC_8259.Object([
                                                                ("offset", .number(RFC_8259.Number(420))),
                                                                ("reference", .string("SPDXRef-DoapSource")),
                                                            ])
                                                        )
                                                    ),
                                                    (
                                                        "startPointer",
                                                        .object(
                                                            RFC_8259.Object([
                                                                ("offset", .number(RFC_8259.Number(310))),
                                                                ("reference", .string("SPDXRef-DoapSource")),
                                                            ])
                                                        )
                                                    ),
                                                ])
                                            ),
                                            .object(
                                                RFC_8259.Object([
                                                    (
                                                        "endPointer",
                                                        .object(
                                                            RFC_8259.Object([
                                                                ("lineNumber", .number(RFC_8259.Number(23))),
                                                                ("reference", .string("SPDXRef-DoapSource")),
                                                            ])
                                                        )
                                                    ),
                                                    (
                                                        "startPointer",
                                                        .object(
                                                            RFC_8259.Object([
                                                                ("lineNumber", .number(RFC_8259.Number(5))),
                                                                ("reference", .string("SPDXRef-DoapSource")),
                                                            ])
                                                        )
                                                    ),
                                                ])
                                            ),
                                        ])
                                    )
                                ),
                                ("snippetFromFile", .string("SPDXRef-DoapSource")),
                            ])
                        )
                    ])
                )
            ),
            (
                "relationships",
                .array(
                    RFC_8259.Array([
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-DOCUMENT")),
                                ("relatedSpdxElement", .string("SPDXRef-Package")),
                                ("relationshipType", .string("CONTAINS")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-DOCUMENT")),
                                ("relatedSpdxElement", .string("DocumentRef-spdx-tool-1.2:SPDXRef-ToolsElement")),
                                ("relationshipType", .string("COPY_OF")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-DOCUMENT")),
                                ("relatedSpdxElement", .string("SPDXRef-File")),
                                ("relationshipType", .string("DESCRIBES")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-DOCUMENT")),
                                ("relatedSpdxElement", .string("SPDXRef-Package")),
                                ("relationshipType", .string("DESCRIBES")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-Package")),
                                ("relatedSpdxElement", .string("SPDXRef-JenaLib")),
                                ("relationshipType", .string("CONTAINS")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-Package")),
                                ("relatedSpdxElement", .string("SPDXRef-Saxon")),
                                ("relationshipType", .string("DYNAMIC_LINK")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-CommonsLangSrc")),
                                ("relatedSpdxElement", .string("NOASSERTION")),
                                ("relationshipType", .string("GENERATED_FROM")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-JenaLib")),
                                ("relatedSpdxElement", .string("SPDXRef-Package")),
                                ("relationshipType", .string("CONTAINS")),
                            ])
                        ),
                        .object(
                            RFC_8259.Object([
                                ("spdxElementId", .string("SPDXRef-File")),
                                ("relatedSpdxElement", .string("SPDXRef-fromDoap-0")),
                                ("relationshipType", .string("GENERATED_FROM")),
                            ])
                        ),
                    ])
                )
            ),
        ])
    )

}
