Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C985FEA0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 01:27:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E70DD212B0FFD;
	Thu,  4 Jul 2019 16:27:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8E44B212B0FF6
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 16:27:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b7so7263005otl.11
 for <linux-nvdimm@lists.01.org>; Thu, 04 Jul 2019 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=29vsGpTjh39zWXsI6Ik43Nv+EdiuWAOV6vxVTajp20k=;
 b=xPh6pbcmI7ZR83uwzt44/h5WZ1jKG98r+LQaDHsemaTjfAFmLK4NHwQNObxnmJM5M8
 kiKlk4co3uBSxHYbFY+WMMvf50uquNZyF0w7RVkb+wN9QHaDcveJWANUrWindaZdPjYX
 fRPefhjZL+h/GTwMBlPyo/7+/fOiU2/TzGWz4bA8jxIM0dAKYaLHEKDaVOkAQSEXS/JJ
 HntfFU+nDsisSL67tqCRY1E2FW29XVGHkHGY+9yi5XPwwkF8dUbKQwZFovjFinBx4P3H
 +CX76/THYqM9Ar2u/pO3kfTI759leI2eRYxgBjawd3DUVZuTF7q3s4H/zjBzZl96hbN0
 jkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=29vsGpTjh39zWXsI6Ik43Nv+EdiuWAOV6vxVTajp20k=;
 b=DTD2fx3Elxa2S7iDX3VDr3hmfDbj5t0mQozNb4Ip49GPU1h9I9ez+JSPJULniLIgel
 iZEcpbpDAnMh9aRBqsgB0xzsH/kRPx4hcKmkfzBBm2S+Be1r9jt4XOlsrh3pxDmQHIPV
 aLsTE6UO4cRZN6TJdKET1GyJNardBFGDx5rVcMisogt52wBkki4AXfQK2uwsMhEaknjI
 hEPDBlOuBqCZlqaGLxN0ifDGOBO9b9hp3YJHtomkPLyMv0W0xIoH9NbMeKeSTqyZmm1O
 ibfPT5KkyOvWVDe+U1Cqei2LjjbhD9zGLz9H1oHDtDQR5SALorMO8TREFg/7r7BnAD57
 NPTg==
X-Gm-Message-State: APjAAAXNv/hIKra/ykKez3sNQl+z05evS9W5xdgPlqkTmgvnAY2ee9iH
 nc+d1mD5a5KQj/5plOzqAMcsvxHGWxj+hnu38zSRQQ==
X-Google-Smtp-Source: APXvYqzFfoPnlwPxd7HMRN1iiNSb0TD46BOhSl+i1LNcRaH8pGkExzmOgi5cRwt9v88JBevUo0Jwrlqmbeg2el1s4mY=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr386103otn.71.1562282845133;
 Thu, 04 Jul 2019 16:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
In-Reply-To: <20190704191407.GM1729@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 4 Jul 2019 16:27:14 -0700
Message-ID: <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Matthew Wilcox <willy@infradead.org>
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jul 4, 2019 at 12:14 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 04, 2019 at 06:54:50PM +0200, Jan Kara wrote:
> > On Wed 03-07-19 20:27:28, Matthew Wilcox wrote:
> > > So I think we're good for all current users.
> >
> > Agreed but it is an ugly trap. As I already said, I'd rather pay the
> > unnecessary cost of waiting for pte entry and have an easy to understand
> > interface. If we ever have a real world use case that would care for this
> > optimization, we will need to refactor functions to make this possible and
> > still keep the interfaces sane. For example get_unlocked_entry() could
> > return special "error code" indicating that there's no entry with matching
> > order in xarray but there's a conflict with it. That would be much less
> > error-prone interface.
>
> This is an internal interface.  I think it's already a pretty gnarly
> interface to use by definition -- it's going to sleep and might return
> almost anything.  There's not much scope for returning an error indicator
> either; value entries occupy half of the range (all odd numbers between 1
> and ULONG_MAX inclusive), plus NULL.  We could use an internal entry, but
> I don't think that makes the interface any easier to use than returning
> a locked entry.
>
> I think this iteration of the patch makes it a little clearer.  What do you
> think?
>

Not much clearer to me. get_unlocked_entry() is now misnamed and this
arrangement allows for mismatches of @order argument vs @xas
configuration. Can you describe, or even better demonstrate with
numbers, why it's better to carry this complication than just
converging the waitqueues between the types?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
