Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591815A0C4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 18:28:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CA45212AB4EA;
	Fri, 28 Jun 2019 09:27:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A0AAA212AB4E1
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:27:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j19so6584500otq.2
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1m5eUNW/8O3Uia+UgF1DOs7nZbA/5lPFN6ZbyXe0/Ls=;
 b=cOaWk12t9PR+wM1gV05bVlfR0S1JSjfvb0hJ6JHo5ppfgDNgrz3BIflcx5b+w4agLb
 brYamehqIiFRGAjIKCUe6+Q53dn3hCuKVsdvquxg1/zCaxiJNgcnspoK9aZ9PKMXCUax
 piwsxxk5ZVG0/OrqNggRtsNENyTRYeAIsTv0w6rRIv8xEx0MB8nULTH+IB0NC3xJ3BeI
 w9h4nLRfPNokhqWP61aJrHtY0lfJBXalafI60Q5aBVAiBp99b8Xbt//EkmWeTAvVPTH8
 cyXy8F6iRDlqKv+0BbiPuN3y3R6N6GvMZWeSpv1agBiqh/rGomhhdkAUvQejKMcw69mS
 wn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1m5eUNW/8O3Uia+UgF1DOs7nZbA/5lPFN6ZbyXe0/Ls=;
 b=VhhFqOvENSWIieulE6UII6ovDZGcdbgTreENw8wr33sLNs323Xqj6DBik2UZ/AF4Bi
 m1HUeQPRuwvWQ8zoTX3pwf6DsNDLPqTnToYZfcrtZFpYySV0dZ+qdZYtpNYupZo+UQsR
 8XMfjhT4cZKXfpih7wqa1HWSR4yPVkO51wztlEFHSgXyIc+ued4NNR+1JIgUIpB5ezA5
 uo4SZzvlDcq7zThEQ46icd3IpnFsu7OVonaHhuO83rMsjIE5p/FUt0gtflxJGQ+q/wfN
 N3PQ1vytwZWjZzIvuOISFcwr3jVLcMnKxGtHnlHEjlg0ub48GdCDh37cgKGNSygs/7co
 9p/w==
X-Gm-Message-State: APjAAAUnBfRXZfY5ot6AkkOmiMyoo8trn6xDrRWErfEeuHDkWZW4uw16
 hjM9xp/3YHSNxHBhm/og3sjWihQxl6dgQbaI85oZVQ==
X-Google-Smtp-Source: APXvYqzpE+Kqyx1ivu95dqxD5Xmw+1dAtjgOIlYl2JIyAfPlIWR3aLAm88Jb4Ju/vM/swOByZ/3NEnMvyOQmHp503wY=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr9100984otk.363.1561739275009; 
 Fri, 28 Jun 2019 09:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
In-Reply-To: <20190628153827.GA5373@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 09:27:44 -0700
Message-ID: <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To: Jason Gunthorpe <jgg@mellanox.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > The functionality is identical to the one currently open coded in
> > device-dax.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/dax/dax-private.h |  4 ----
> >  drivers/dax/device.c      | 43 ---------------------------------------
> >  2 files changed, 47 deletions(-)
>
> DanW: I think this series has reached enough review, did you want
> to ack/test any further?
>
> This needs to land in hmm.git soon to make the merge window.

I was awaiting a decision about resolving the collision with Ira's
patch before testing the final result again [1]. You can go ahead and
add my reviewed-by for the series, but my tested-by should be on the
final state of the series.

[1]: https://lore.kernel.org/lkml/CAPcyv4gTOf+EWzSGrFrh2GrTZt5HVR=e+xicUKEpiy57px8J+w@mail.gmail.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
