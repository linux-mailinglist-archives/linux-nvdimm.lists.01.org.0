Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D437D5EAD7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 19:51:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E65A212ACECD;
	Wed,  3 Jul 2019 10:50:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.128.66; helo=mail-wm1-f66.google.com;
 envelope-from=ibmirkin@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B1AD3212AB4F2
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 10:50:57 -0700 (PDT)
Received: by mail-wm1-f66.google.com with SMTP id h19so3457503wme.0
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 10:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hndznlvzR7hCc155DH4EmepiersU9zF+O4Q02wI0fg0=;
 b=o6593kOT3MzxmTFtgzFp28x5yBMLdjEE549UoyV2mAkiHvNVOTn00XCYqg36vl9S45
 e37JwudLFJ17Ok+UXxW3/BP8As380krvIp1h08FNg+sMnXwSbGTwZJkhMdokx33Jutm5
 K8hRcYZDtIfXnx46VP2IYe5iqDNxKY3fMrrx3f0JpZa+k6fKZUHC3l1Xxy2GVSdLhYku
 9dk1ZAWQU3rxxMPUPTlSUzgT81jJ80x+mFrbwqgRxfeDp2ll2l/6Vt4R8wx//yKb8our
 Q04vPy+BTBtQzLf+YFTYHCKH2ZqVj2M2u7IBlipzmleSf/xQC/AaaL/V8rEsVgG8ZENR
 EXmg==
X-Gm-Message-State: APjAAAWGMFkdgOfPuoQpec9Z0TLOG0e/WTrRbI5RRoeA64SxpHtg5AF7
 kmCNjD1ehzwiizR7VwcBPWC672q7LcSvv7zRSKA=
X-Google-Smtp-Source: APXvYqwbLyqNJUgVnFhv0lbJ8SC5c/0yPQg1tb9jN6EfSosXHl80EFPU2XUiDskY7sdqSQfVQLihXsM+BDW3vYzudVA=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr8920034wmc.169.1562176256213; 
 Wed, 03 Jul 2019 10:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-21-hch@lst.de>
 <a3108540-e431-2513-650e-3bb143f7f161@nvidia.com>
In-Reply-To: <a3108540-e431-2513-650e-3bb143f7f161@nvidia.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Wed, 3 Jul 2019 13:50:45 -0400
Message-ID: <CAKb7Uvid7xfWNRxee4YoDSKu5-eizo-0Bqb3amFczEDXmSKLMA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 20/22] mm: move hmm_vma_fault to nouveau
To: Ralph Campbell <rcampbell@nvidia.com>
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
Cc: linux-nvdimm@lists.01.org, Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-mm@kvack.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau <nouveau@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 3, 2019 at 1:49 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
> On 6/30/19 11:20 PM, Christoph Hellwig wrote:
> > hmm_vma_fault is marked as a legacy API to get rid of, but quite suites
> > the current nouvea flow.  Move it to the only user in preparation for
>
> I didn't quite parse the phrase "quite suites the current nouvea flow."
> s/nouvea/nouveau/

As long as you're fixing typos, suites -> suits.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
