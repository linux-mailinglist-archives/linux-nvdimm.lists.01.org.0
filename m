Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC76271D24
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 10:08:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67C87143B17F5;
	Mon, 21 Sep 2020 01:08:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6EB7143B2593
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 01:07:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4BvxrN6CR4z9sRf;
	Mon, 21 Sep 2020 18:07:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
	s=201702; t=1600675674;
	bh=iaBdLJOvxyJXfcUEqmY+3Nksf5Jf9xHCFLBtVdF2GM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5wKwexmDJAci9TTwYRSQ0w9PM5CiPqAwagC2tcao/hBigyuoMxG1C8D0UmTRvwbU
	 EhPScTRFe/siLj3BjXiyv9uIFmQY0S4UmOdPSVysuZGSDahrfPB83W3uawREPQpzd0
	 kHld44CU++GsPbN3dC1XVd4QoBpM6Lgj+V1kNNdSetTvjN8TgT8QvRc6F00jrjsQD6
	 lDVtnrJaxh5Jw5LEvG/jpEkcuTha5XPYFINClW5XVtzMcKkHT38c4BYivb3A3RLDRr
	 JaS6Iuw/LnkzJSYvM742RWyWBJTrmzSqPEqXAqPcsYg8niNwEgDNwWig1CMgfOS4OB
	 vkx4v/7kdkZQQ==
Date: Mon, 21 Sep 2020 18:07:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Qian Cai <cai@redhat.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200921180748.4f88028d@canb.auug.org.au>
In-Reply-To: <fdd0240c187f974fccc553acea895f638d5e822a.camel@redhat.com>
References: <20200916073539.3552-1-rppt@kernel.org>
	<5d97da4d86db258fdc9b20be3c12588089e17da2.camel@redhat.com>
	<fdd0240c187f974fccc553acea895f638d5e822a.camel@redhat.com>
MIME-Version: 1.0
Message-ID-Hash: E2PD543NPWZYERUIMJ3ZFWT6V3Z7T3BC
X-Message-ID-Hash: E2PD543NPWZYERUIMJ3ZFWT6V3Z7T3BC
X-MailFrom: sfr@canb.auug.org.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.ker
 nel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-next@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E2PD543NPWZYERUIMJ3ZFWT6V3Z7T3BC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============5073416077294117825=="

--===============5073416077294117825==
Content-Type: multipart/signed; boundary="Sig_/qIGimAfxVKTvCJ+PllFC0A/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qIGimAfxVKTvCJ+PllFC0A/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 18 Sep 2020 14:25:15 -0400 Qian Cai <cai@redhat.com> wrote:
>
> On Thu, 2020-09-17 at 09:27 -0400, Qian Cai wrote:
> > On Wed, 2020-09-16 at 10:35 +0300, Mike Rapoport wrote: =20
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >=20
> > > This is an implementation of "secret" mappings backed by a file descr=
iptor.=20
> > > I've dropped the boot time reservation patch for now as it is not str=
ictly
> > > required for the basic usage and can be easily added later either wit=
h or
> > > without CMA. =20
> >=20
> > On powerpc: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.co=
nfig
> >=20
> > There is a compiling warning from the today's linux-next:
> >=20
> > <stdin>:1532:2: warning: #warning syscall memfd_secret not implemented =
[-Wcpp] =20
>=20
> This should silence the warning:
>=20
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index a18b47695f55..b7609958ee36 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -40,6 +40,10 @@ cat << EOF
>  #define __IGNORE_setrlimit	/* setrlimit */
>  #endif
> =20
> +#ifndef __ARCH_WANT_MEMFD_SECRET
> +#define __IGNORE_memfd_secret
> +#endif
> +
>  /* Missing flags argument */
>  #define __IGNORE_renameat	/* renameat2 */
>=20

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/qIGimAfxVKTvCJ+PllFC0A/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9oX1QACgkQAVBC80lX
0GwVfQgAho6bGSHnGAjI0IiMmFRLcHM+KMH0XiVgh9bvUjVASl1mVgeIe7v//Oef
uyH9zCWyUFof0EnaT4f5uZctC2pe/qvb7BsEdaSlLUSz4X8J1xLWfdYbdJHMvtYR
WnrFHwGCmEtpImNTTZtXcdDZeliVgq41XGd/h1Z59o6givzPYTtIK59LlOOcZj3y
KIY0ELXUPauFOINBbfRzs0xlB6upYfVrHUdh9/glsrY4wVcEfPhjgFVAk+Ua/4/E
/ksLJ+WeUZxJ/2SOPL5Vm23vZvmSE0fD4krBBiANbBiKShRgJRU21uc/ulEdHh5E
qZjQA6jjcKFGbIbi78Sb6LxIzI/mKQ==
=OfZk
-----END PGP SIGNATURE-----

--Sig_/qIGimAfxVKTvCJ+PllFC0A/--

--===============5073416077294117825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============5073416077294117825==--
