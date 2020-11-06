Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D050F2A8F8A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 07:40:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07D6812A17B6C;
	Thu,  5 Nov 2020 22:40:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F3ED100A01A4
	for <linux-nvdimm@lists.01.org>; Thu,  5 Nov 2020 22:40:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4CS9kB07Z4z9sRK;
	Fri,  6 Nov 2020 17:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
	s=201702; t=1604644822;
	bh=4gkQRIBRnS4TBA+uN2ymy2jL+Yn0naxTFoCuzo4imw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZU30Q/ywEpioSKQVsEQ+qjSVJocvP7yrqDwgbNrcXb7TxyF/BaTKoTlJx4qMaMuC
	 BHKtjygNwqRcU4kopBzXlXIUfQY5lvq0Zvn8H6mu8sAOXdIDYuww4umyMkzohdGdAD
	 Nhx4TI3NirOaBohd3VJDgwMcj3nmni3pinmZ/lNyOaIGjQLsxrLnMEimtzNy4iul5O
	 oEcho3xTw5x+Y+tlPgfGnsqG4yLHzJuOAnkwEScs95r3PBnr7zYUPcfcljtr10Yiqk
	 2+LBsv1uLhKCyZGL4OmD3dX2KAw4p7uuPofnUbZ616M1VMgiHbNyapkKGqw80Sz/pe
	 B1uruls7sHvRw==
Date: Fri, 6 Nov 2020 17:40:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4] mm: Fix phys_to_target_node() and
 memory_add_physaddr_to_nid() exports
Message-ID: <20201106174016.59a2bfb2@canb.auug.org.au>
In-Reply-To: <160461461867.1505359.5301571728749534585.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160461461867.1505359.5301571728749534585.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID-Hash: PT5WPCGAQDBRQKAXHNWSIJUPBRPFARKE
X-Message-ID-Hash: PT5WPCGAQDBRQKAXHNWSIJUPBRPFARKE
X-MailFrom: sfr@canb.auug.org.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PT5WPCGAQDBRQKAXHNWSIJUPBRPFARKE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============7253319234799674228=="

--===============7253319234799674228==
Content-Type: multipart/signed; boundary="Sig_/Y_kTeFZZ18zhKZijEZoNUv6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Y_kTeFZZ18zhKZijEZoNUv6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 05 Nov 2020 14:20:45 -0800 Dan Williams <dan.j.williams@intel.com> =
wrote:
>
> The core-mm has a default __weak implementation of phys_to_target_node()
> to mirror the weak definition of memory_add_physaddr_to_nid(). That
> symbol is exported for modules. However, while the export in
> mm/memory_hotplug.c exported the symbol in the configuration cases of:
>=20
> 	CONFIG_NUMA_KEEP_MEMINFO=3Dy
> 	CONFIG_MEMORY_HOTPLUG=3Dy
>=20
> ...and:
>=20
> 	CONFIG_NUMA_KEEP_MEMINFO=3Dn
> 	CONFIG_MEMORY_HOTPLUG=3Dy
>=20
> ...it failed to export the symbol in the case of:
>=20
> 	CONFIG_NUMA_KEEP_MEMINFO=3Dy
> 	CONFIG_MEMORY_HOTPLUG=3Dn
>=20
> Not only is that broken, but Christoph points out that the kernel should
> not be exporting any __weak symbol, which means that
> memory_add_physaddr_to_nid() example that phys_to_target_node() copied
> is broken too.
>=20
> Rework the definition of phys_to_target_node() and
> memory_add_physaddr_to_nid() to not require weak symbols. Move to the
> common arch override design-pattern of an asm header defining a symbol
> to replace the default implementation.
>=20
> The only common header that all memory_add_physaddr_to_nid() producing
> architectures implement is asm/sparsemem.h. In fact, powerpc already
> defines its memory_add_physaddr_to_nid() helper in sparsemem.h.
> Double-down on that observation and define phys_to_target_node() where
> necessary in asm/sparsemem.h. An alternate consideration that was
> discarded was to put this override in asm/numa.h, but that entangles
> with the definition of MAX_NUMNODES relative to the inclusion of
> linux/nodemask.h, and requires powerpc to grow a new header.
>=20
> The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
> now that the symbol is properly exported / stubbed in all combinations
> of CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target=
_node() implementation")
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v3 [1]:
> - (Stephen) PowerPC header include dependencies make it difficult to
>   include asm/sparsemem.h in linux/numa.h due to missing definition of
>   pgprot.  Move the declaration of create_section_mapping() to
>   asm/mmzone.h. This has received a build success notification from the
>   kbuild-robot over 159 configs.

I replaced the previous version in linux-next with this today.  Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y_kTeFZZ18zhKZijEZoNUv6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+k79AACgkQAVBC80lX
0GxcdQf/RSVyUmmC0LZ7GOxRFITkfQy3+JTAaPWls21QnKUMxQ70oeTOBvmQRPnf
ijrFuJsCd7Tc9JNQoHfMxXyU0WfEU1H2PpXxeveiCD0SqL/WQ4W2U7LTeR+rKP6v
36P96eG2OGmvznQKpdVAqU8B21KNZuaBam+8uepit1iGOb+LTmZITd93uh/1B2xc
5LoclZpuNBUSuMyBQAswxs6psEnGStYPgnfqVGW13gzqxARTCk44s1n4/VdxJR0K
Y3KMvXyTZc2cX6apVKJE8tODtXke69dR9iYxGvuEDuYLS/ydTeG40Gev5E0CpVtq
2wnAeZ++vGkZ340pKMyRr39DJiOjdw==
=u2UN
-----END PGP SIGNATURE-----

--Sig_/Y_kTeFZZ18zhKZijEZoNUv6--

--===============7253319234799674228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============7253319234799674228==--
