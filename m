Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB31DE60D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 14:00:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4451E11FC5655;
	Fri, 22 May 2020 04:56:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DD7CA11FB7240
	for <linux-nvdimm@lists.01.org>; Fri, 22 May 2020 04:56:34 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7AF10206B6;
	Fri, 22 May 2020 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590148811;
	bh=za+1x7fC+5cQVdg7KBn+1sPJn8MXsHpslPvJp9Y3ggs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5ep2rb8pfRdxwG35Hv38VKzEj2tsUyqLnIvp1cOF3Nj9UzTSI25jhq1WNP8ch3bk
	 GkrBGbRr0s6BbAvuE9F7Fp8FQ9i+jxJ0hGJy9ExwvdHFy3WRHGmg1u7/vvi5PrOb+g
	 7L7QUCImxtM623tacD1UMPRKKtv53jU2F2Xo4+Kw=
Date: Fri, 22 May 2020 14:00:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [5.4-stable PATCH 0/7] libnvdimm: Cross-arch compatible
 namespace alignment
Message-ID: <20200522120009.GA1456052@kroah.com>
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200522115800.GA1451824@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200522115800.GA1451824@kroah.com>
Message-ID-Hash: ILXE45CSDVK5VJ6RNX3KDWFKHU3QZXHR
X-Message-ID-Hash: ILXE45CSDVK5VJ6RNX3KDWFKHU3QZXHR
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: stable@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ILXE45CSDVK5VJ6RNX3KDWFKHU3QZXHR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 01:58:00PM +0200, Greg KH wrote:
> On Thu, May 21, 2020 at 04:37:43PM -0700, Dan Williams wrote:
> > Hello stable team,
> > 
> > These patches have been shipping in mainline since v5.7-rc1 with no
> > reported issues. They address long standing problems in libnvdimm's
> > handling of namespace provisioning relative to alignment constraints
> > including crashes trying to even load the driver on some PowerPC
> > configurations.
> > 
> > I did fold one build fix [1] into "libnvdimm/region: Introduce an 'align'
> > attribute" so as to not convey the bisection breakage to -stable.
> > 
> > Please consider them for v5.4-stable. They do pass the latest
> > version of the ndctl unit tests.
> 
> What about 5.6.y?  Any user upgrading from 5.4-stable to 5.6-stable
> would hit a regression, right?
> 
> So can we get a series backported to 5.6.y as well?  I need that before
> I can take this series.

Also, I really don't see the "bug" that this is fixing here.  If this
didn't work on PowerPC before, it can continue to just "not work" until
5.7, right?  What problems with 5.4.y and 5.6.y is this series fixing
that used to work before?

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
