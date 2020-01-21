Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A98314376B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 08:12:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56F1710097DDC;
	Mon, 20 Jan 2020 23:15:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.105.76.150; helo=10.mo178.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from 10.mo178.mail-out.ovh.net (10.mo178.mail-out.ovh.net [46.105.76.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02DAB10113602
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 23:15:32 -0800 (PST)
Received: from player695.ha.ovh.net (unknown [10.108.35.185])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D63318D415
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 08:12:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
	(Authenticated sender: groug@kaod.org)
	by player695.ha.ovh.net (Postfix) with ESMTPSA id 478D9E528FFF;
	Tue, 21 Jan 2020 07:11:28 +0000 (UTC)
Date: Tue, 21 Jan 2020 08:11:26 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
Message-ID: <20200121081126.2f9c6972@bahia.lan>
In-Reply-To: <f33979a2-a083-dd0e-3273-7ebff66d6385@linux.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-6-alastair@au1.ibm.com>
	<f33979a2-a083-dd0e-3273-7ebff66d6385@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Ovh-Tracer-Id: 11838274572983900498
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvughimhhmsehlihhsthhsrddtuddrohhrgh
Message-ID-Hash: PCQBTJQRVRS5PKIU7TNYDXTLQ37J5B3Q
X-Message-ID-Hash: PCQBTJQRVRS5PKIU7TNYDXTLQ37J5B3Q
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozla
 bs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PCQBTJQRVRS5PKIU7TNYDXTLQ37J5B3Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2020 17:46:12 +1100
Andrew Donnellan <ajd@linux.ibm.com> wrote:

> On 3/12/19 2:46 pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch adds platform support to map & release LPC memory.
> 
> Might want to explain what LPC is.
> 
> Otherwise:
> 
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
> >   arch/powerpc/platforms/powernv/ocxl.c | 42 +++++++++++++++++++++++++++
> >   2 files changed, 44 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> > index 7de82647e761..f8f8ffb48aa8 100644
> > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
> >   
> >   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> >   extern void pnv_ocxl_free_xive_irq(u32 irq);
> > +extern u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
> > +extern void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
> 
> nit: I don't think these need to be extern?
> 
> 

And even if they were, as verified by checkpatch:

"extern prototypes should be avoided in .h files"
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
