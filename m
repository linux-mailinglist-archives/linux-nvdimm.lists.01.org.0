Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E822AEF4D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 12:13:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E314C1673CADF;
	Wed, 11 Nov 2020 03:13:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8F6DF1672CA56
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 03:13:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4CWMXV5mSTz9sSs;
	Wed, 11 Nov 2020 22:12:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
	s=201702; t=1605093181;
	bh=QE1/yS9A+y7apFmQa9E6DBK0BKDrYI0qrcJCc+5O2Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSivZMUuFx6UDN1/vyBmQUbbtks3lK2MkkHMbBq91c8+7lsfmb4kP9XSt1DqdaCTH
	 A35OlMR2A1BcFrEpEKGWBb2xdfRfrEyYVAtR2Z/G74lbvUPE+beBdkmDI1yFVyRGH6
	 uTkr7ptr4paiukHoqOz4tjWOXhgUbBmQwLkvNCRCLyVvQYGosYQ3q5Gbw5escDzjQL
	 8MoR2Z5fSscYhDwxMqTzrTlarhysFifkwLFSuxsDdhioAPk1ub6xUqUSF6sIqZ3jwf
	 B1JeOQ0zWASSBvCKQx5ayHpPHvO+53ojBuJqQNfuWr+thoL7BB9pIfESms+vG4vw6P
	 d6742qRZd1oxQ==
Date: Wed, 11 Nov 2020 22:12:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Message-ID: <20201111221254.7f6a3658@canb.auug.org.au>
In-Reply-To: <20201111082842.GA23677@lst.de>
References: <20201029101432.47011-3-hch@lst.de>
	<20201111022122.1039505-1-ndesaulniers@google.com>
	<20201111081800.GA23492@lst.de>
	<673267d5-93f5-7278-7a9d-a7b35ede6d48@de.ibm.com>
	<20201111082842.GA23677@lst.de>
MIME-Version: 1.0
Message-ID-Hash: 3PTUTO3WJSX47YB6RYLQYO7JJUED343P
X-Message-ID-Hash: 3PTUTO3WJSX47YB6RYLQYO7JJUED343P
X-MailFrom: sfr@canb.auug.org.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christian Borntraeger <borntraeger@de.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>, akpm@linux-foundation.org, daniel@ffwll.ch, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, clang-built-linux@googlegroups.com, Linux-Next Mailing List <linux-next@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PTUTO3WJSX47YB6RYLQYO7JJUED343P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============1211472155932878259=="

--===============1211472155932878259==
Content-Type: multipart/signed; boundary="Sig_/Mc_NX=GVNozxrVPRgbb7NWp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Mc_NX=GVNozxrVPRgbb7NWp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 11 Nov 2020 09:28:42 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 11, 2020 at 09:26:20AM +0100, Christian Borntraeger wrote:
> >=20
> > On 11.11.20 09:18, Christoph Hellwig wrote: =20
> > > On Tue, Nov 10, 2020 at 06:21:22PM -0800, Nick Desaulniers wrote: =20
> > >> Sorry, I think this patch may be causing a regression for us for s39=
0?
> > >> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/=
jobs/432129279#L768
> > >>
> > >> (via https://lore.kernel.org/linux-mm/20201029101432.47011-3-hch@lst=
.de) =20
> > >=20
> > > Hmm, the call to follow_pte_pmd in the s390 code does not actually ex=
ist
> > > in my tree. =20
> >=20
> > This is a mid-air collision in linux-next between
> >=20
> > b2ff5796a934 ("mm: simplify follow_pte{,pmd}")
> > a67a88b0b8de ("s390/pci: remove races against pte updates") =20
>=20
> Ah.  The fixup is trivial: just s/follow_pte_pmd/follow_pte/.

ok, so tomorrow I will add the following to the merge of the
akpm-current tree:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 11 Nov 2020 22:08:32 +1100
Subject: [PATCH] merge fix for "s390/pci: remove races against pte updates"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/s390/pci/pci_mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 1a6adbc68ee8..4a4993837413 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -173,7 +173,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmi=
o_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
=20
-	ret =3D follow_pte_pmd(vma->vm_mm, mmio_addr, NULL, &ptep, NULL, &ptl);
+	ret =3D follow_pte(vma->vm_mm, mmio_addr, NULL, &ptep, NULL, &ptl);
 	if (ret)
 		goto out_unlock_mmap;
=20
@@ -317,7 +317,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio=
_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
=20
-	ret =3D follow_pte_pmd(vma->vm_mm, mmio_addr, NULL, &ptep, NULL, &ptl);
+	ret =3D follow_pte(vma->vm_mm, mmio_addr, NULL, &ptep, NULL, &ptl);
 	if (ret)
 		goto out_unlock_mmap;
=20
--=20
2.29.2

--=20
Cheers,
Stephen Rothwell

--Sig_/Mc_NX=GVNozxrVPRgbb7NWp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+rxzYACgkQAVBC80lX
0GzxoggAnTSbP2MvHm/AvrWkgYxvOlLSLXdQ/ImkKzdhpKhThkA1ncXWZFIvTgHc
46Y9TwSWR1HQOm/f/jyDe0qAIJP0857bxOHXTlFvY/3FSDv+WZc/2pSf1v5zAZnG
edhdutlXgBgCqwhnux5ooDQUqwjwqiom+evJLaLtWzRAopB3QoLWA4vjk3KQ4HPa
Z30h1i+dcqrXCDfbELftpAIDBZ7S0OWZakJzDPWKAYHlz4cbV/BhkDRf9rpb0i+I
c/tpAnopxEVSWx1JCooiR7ZC2y/kXNl18K+Y83xy8bJdAmaR1jCSqlZsHDdBnpU3
k/JOL0denkdXvrOMB7V3apBHpRJ8iQ==
=AA7r
-----END PGP SIGNATURE-----

--Sig_/Mc_NX=GVNozxrVPRgbb7NWp--

--===============1211472155932878259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============1211472155932878259==--
