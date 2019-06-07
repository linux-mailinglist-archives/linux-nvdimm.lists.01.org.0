Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9593967C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 22:10:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9546221295B01;
	Fri,  7 Jun 2019 13:10:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E19DF21290DFA
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 13:10:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so3010548otr.3
 for <linux-nvdimm@lists.01.org>; Fri, 07 Jun 2019 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QlVygW5HX3gMOqI9iagu+o2KfHmRD4CVE+mKAqVQHDc=;
 b=brKoMC2YNPiZDdbuJUJptjoM9KaSU8S4ObGocQkg1KQo4JtkdYErEgLDttxwqmD1JH
 dL/IlNi9BXKIc8G2/scgxlh4GMR1LPlSwT1q5vcXHrdpTfXILVnLCPxnCBYk7gUFnfFF
 NdgiE59NbaWDqNP5wfElrVabi+k2yJJyvfJduho23fxEAZDaN8S5AlfdlL96Y1r7QtR1
 A3okrfILjOgYAttOW90Hvjo0YcQe/1HvRH2+1CnF6pxcSFE6miNDAwBkMxuMaeftbxpC
 eVrIbhAE3WWKVoxN2mrCw1iTp9wy3oCPHn39dU3YvYz4bSqNGMa2gZQYQQPeD7kvC730
 R67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QlVygW5HX3gMOqI9iagu+o2KfHmRD4CVE+mKAqVQHDc=;
 b=PzwNgfnjzEPOWTQpc17OLgiYi0bVwPwsaJ1Od02VDQsuu2mUXho/yWN2YXy5J07W2r
 xLSUos6KCnPb++VzXQw0AN97G3fuUqZe5FC7HjrBDIzdfFtqL5J2JsSB0RaDkAdx9gz2
 MHiZg0H90EJFDLNUB1VoZ4RDi2Ju59Ns55nwLSc9gcZhp7y1hPDqFH90pSe5eCiSXgcQ
 Izsu0QaZYwbdrTgPnM8ag+lP5ySuKjm1/bjXIozslam2hsHrIp9oXAcKUBYCV17yujIH
 kuPYiWEBRzUQuyyrXdueLeekHeLWXb4PUkJki5n5jpw09352D4IHsBZuxKTPIsQbPTU8
 B/uw==
X-Gm-Message-State: APjAAAWgsxS7D78FmDOYn2dSCQOEFioKjqIoc9ZWi4t7iYl+PXX33kJf
 jNYK2YTQqDH42Lg34D54OOroaLl54812wOt8cK5IWKjr
X-Google-Smtp-Source: APXvYqza6PFTcS6UhXtsr41/gRao+O5Nm4kLPIDhyAJGiSy5KNxsRBiCwJGc9Q8H+D6BnJ2xLKRvXnTj8YRz1komqIE=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr20388166otk.363.1559938209740; 
 Fri, 07 Jun 2019 13:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
 <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com>
 <20190607125430.81e63cd56590ab3fea37a635@linux-foundation.org>
In-Reply-To: <20190607125430.81e63cd56590ab3fea37a635@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Jun 2019 13:09:58 -0700
Message-ID: <CAPcyv4iSndjxgQZq1HtsyY5=h837b-MY3FNDzAdrBGiKJGwOvw@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
To: Andrew Morton <akpm@linux-foundation.org>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 7, 2019 at 12:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 6 Jun 2019 15:06:26 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Jun 6, 2019 at 2:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > At namespace creation time there is the potential for the "expected to
> > > > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > > > data. While the kernel buffer is zeroed on allocation it is immediately
> > > > overwritten by nd_pfn_validate() filling it with the current contents of
> > > > the on-media info-block location. For fields like, 'flags' and the
> > > > 'padding' it potentially means that future implementations can not rely
> > > > on those fields being zero.
> > > >
> > > > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > > > section alignment, arrange for fields that are not explicitly
> > > > initialized to be guaranteed zero. Bump the minor version to indicate it
> > > > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > > > corruption is expected to benign since all other critical fields are
> > > > explicitly initialized.
> > > >
> > > > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > The cc:stable in [11/12] seems odd.  Is this independent of the other
> > > patches?  If so, shouldn't it be a standalone thing which can be
> > > prioritized?
> > >
> >
> > The cc: stable is about spreading this new policy to as many kernels
> > as possible not fixing an issue in those kernels. It's not until patch
> > 12 "libnvdimm/pfn: Stop padding pmem namespaces to section alignment"
> > as all previous kernel do initialize all fields.
> >
> > I'd be ok to drop that cc: stable, my concern is distros that somehow
> > pickup and backport patch 12 and miss patch 11.
>
> Could you please propose a changelog paragraph which explains all this
> to those who will be considering this patch for backports?
>

Will do. I'll resend the series with this and the fixups proposed by Oscar.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
