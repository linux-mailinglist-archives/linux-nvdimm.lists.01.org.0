Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB1B17D5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 07:00:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA016202E840E;
	Thu, 12 Sep 2019 22:00:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 24F1A202E6E15
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 22:00:33 -0700 (PDT)
Received: from localhost (unknown [84.241.200.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01BAA20717;
 Fri, 13 Sep 2019 05:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568350836;
 bh=yHqpSeWaKdWHTKdxmQpNg5pLxh28uD8FY7G7RDJZJ/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CljD4YMOdbV28FTif1XLxmaHj1ZdQT/ts0RyBESTYvHflGm7l5aP0S7mF1I9mlBqE
 YBX/SmZmIV61gJbWliZToRYsIEX6EhLRBArA0u82XFHM2IaLxKc0IrEZOEqNNpe6no
 QUFTwH/A9myiKrqb3UXL2Jkqu+dmdcpOSlG0LO3Y=
Date: Fri, 13 Sep 2019 06:00:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190913050031.GB128462@kroah.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <c2c734d3-ca8d-8485-9b9e-fd64e12aa0f0@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2c734d3-ca8d-8485-9b9e-fd64e12aa0f0@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 07:41:55AM +0530, Aneesh Kumar K.V wrote:
> On 9/12/19 12:13 AM, Dan Carpenter wrote:
> > On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
> > > +Coding Style Addendum
> > > +---------------------
> > > +libnvdimm expects multi-line statements to be double indented. I.e.
> > > +
> > > +        if (x...
> > > +                        && ...y) {
> > 
> > That looks horrible and it causes a checkpatch warning.  :(  Why not
> > do it the same way that everyone else does it.
> > 
> > 	if (blah_blah_x && <-- && has to be on the first line for checkpatch
> > 	    blah_blah_y) { <-- [tab][space][space][space][space]blah
> > 
> > Now all the conditions are aligned visually which makes it readable.
> > They aren't aligned with the indent block so it's easy to tell the
> > inside from the if condition.
> 
> 
> I came across this while sending patches to libnvdimm subsystem. W.r.t
> coding Style can we have consistent styles across the kernel? Otherwise, one
> would have to change the editor settings as they work across different
> subsystems in the kernel. In this specific case both clang-format and emacs
> customization tip in the kernel documentation directory suggest the later
> style.

We _should_ have a consistent coding style across the whole kernel,
that's the whole reason for having a coding style in the first place!

The problem is, we all have agreed on the "basics" a long time ago, but
are now down in the tiny nits as to what some minor things should, or
should not, look like.

It might be time to just bite the bullet and do something like
"clang-format" to stop arguing about stuff like this for new
submissions, if for no other reason to keep us from wasting mental
energy on trivial things like this.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
