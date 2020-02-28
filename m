Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D542D1731A2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 08:15:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC22A10FC36DB;
	Thu, 27 Feb 2020 23:16:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6B9410FC36DA
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 23:16:15 -0800 (PST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B6D562469D;
	Fri, 28 Feb 2020 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582874123;
	bh=bzqcvY1+w7p+H0tBmGUux2b6d1gIUiq/keZNLNBznKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxdwK4hX9SZG6cAVJ0xxZYzqkemDxOmWY+1cEmTnG4oE4Is+PBG7kHaRUPLcqZa6I
	 d6IGDzBLr4do0Wg1pJ5rCWIJV/BjZIkr2D3Cl0iJkW8GoyZG6jjyNX/oSPJsGpkcGC
	 3xXHY8ZcCXVl//QBuWTZ6yQC5BG057R15eUhlo4Q=
Date: Fri, 28 Feb 2020 08:15:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH v3 25/27] powerpc/powernv/pmem: Expose the serial number
 in sysfs
Message-ID: <20200228071520.GA2897773@kroah.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-26-alastair@au1.ibm.com>
 <96687fbf-38ab-13ff-ca19-ccb67bbc4405@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96687fbf-38ab-13ff-ca19-ccb67bbc4405@linux.ibm.com>
Message-ID-Hash: ZLT3NSV2PTKC3MHQUSHNZHKNDLMXVOHI
X-Message-ID-Hash: ZLT3NSV2PTKC3MHQUSHNZHKNDLMXVOHI
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kern
 el.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZLT3NSV2PTKC3MHQUSHNZHKNDLMXVOHI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2020 at 05:25:31PM +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> > +int ocxlpmem_sysfs_add(struct ocxlpmem *ocxlpmem)
> > +{
> > +	int i, rc;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
> > +		rc = device_create_file(&ocxlpmem->dev, &attrs[i]);
> > +		if (rc) {
> > +			for (; --i >= 0;)
> > +				device_remove_file(&ocxlpmem->dev, &attrs[i]);
> 
> I'd rather avoid weird for loop constructs if possible.
> 
> Is it actually dangerous to call device_remove_file() on an attr that hasn't
> been added? If not then I'd rather define an err: label and loop over the
> whole array there.

None of this should be used at all, just use attribute groups properly
and the driver core will handle this all for you.

device_create/remove_file should never be called by anyone anymore if at all
possible.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
