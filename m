Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D922702AD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 18:55:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16453151B21D8;
	Fri, 18 Sep 2020 09:55:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 305D814E595C2
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 09:55:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so6774731edr.3
        for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxwRMmZAvscI9qLISrOKxKWDWXBsK0Qiq++otHhpMpM=;
        b=vW9xAgzLdO0QTngXP251avBoOv0g0D8jITnPZCJ5/Gugk+FHUHF/kvs6N/4BGb4yRp
         kwWQrpEvWarWlY6oGD1By4fOTSpcnfY6T5RGy1jX3cdIMv/EEDhvGn5NMNtptRwMLdk9
         TeIAV3rz/9S3/Lu+cwsk0KqQ/wvILgP0cetKg5Ci454hEpq8RvIg4WXN774E5PSIoMHa
         DsJC9VcCZV4SAA+etDYxCrS/HmvNAGtSF0KuTLpB/dl9CdoduF6NOwxzGVgG6ZJCJvpV
         bIXTRwy1i/WvQl4YY+EbOK5NGuWUtetdeY9jGfArhxhr2VbmzVU9ho3TRx2nE6NTGkEk
         2xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxwRMmZAvscI9qLISrOKxKWDWXBsK0Qiq++otHhpMpM=;
        b=T9b5vdpMrvmHTORyVE8s7imhkccWoxAnGeq/f595RVkxuDRNGZiQTZJssaVx4xdeVi
         qjxWWvtDL7PvF1inNZNXeX+a/lB7Kub96P9gPDDOkZIxqU6i/xuXFOjkLnpdQsX6ZnGe
         zePX1pILBD4KYcA9xyUBTZZAH/jzIhQ0gZRe/W7vX68UIbgbbUhaGXmphyg0dXip9gVU
         E92mstTrD/QxLqpnstiUBa7WQupKZhiGFWPK+tntr85d+6bq/YLKcNOpUf/um+W6YlOO
         3AoGy3eV+I/g6B/bsxsHz/P//uZprdfPoTd23Z6948qUkTrt1zNOZMtg0f6ZDbJxe6HJ
         NJaQ==
X-Gm-Message-State: AOAM5329VrH+4lEMcqPOKPHrKQM7f1dIWoDZNPuttsmqA02QabACEfGK
	90BWz1/bqjKTspLsWGD/xkFw61slZERYx6xzjc2zCQ==
X-Google-Smtp-Source: ABdhPJxcLHTp2HmWlgI7Su041TxmNFgVD/jngcdBcxMjvp5IOfJeNJy8OR2y4k4Bfa6ELWveIGOQjFysEqiHQiktakY=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr40445469edq.300.1600448103080;
 Fri, 18 Sep 2020 09:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <160040692945.25320.13233625491405115889.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200918153041.GN7954@magnolia>
In-Reply-To: <20200918153041.GN7954@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Sep 2020 09:54:51 -0700
Message-ID: <CAPcyv4ii+NWnJhLWwz=Z+2aAJ=DdjwQoqPC+hO88CsM2ub5FEw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v2] dm: Call proper helper to determine dax support
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: 3BADOBAVFHG3G6QTRZRCIK7LUTGXESH6
X-Message-ID-Hash: 3BADOBAVFHG3G6QTRZRCIK7LUTGXESH6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, Adrian Huang <ahuang12@lenovo.com>, Mikulas Patocka <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3BADOBAVFHG3G6QTRZRCIK7LUTGXESH6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2020 at 8:31 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Sep 17, 2020 at 10:30:03PM -0700, Dan Williams wrote:
> > From: Jan Kara <jack@suse.cz>
> >
> > DM was calling generic_fsdax_supported() to determine whether a device
> > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > they don't have to duplicate common generic checks. High level code
> > should call dax_supported() helper which that calls into appropriate
> > helper for the particular device. This problem manifested itself as
> > kernel messages:
> >
> > dm-3: error: dax access failed (-95)
> >
> > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > another DM device.
>
> Is there somewhere where it is documented which of:
>
> bdev_dax_supported, generic_fsdax_supported, and dax_supported
>
> one is supposed to use for a given circumstance?

generic_fsdax_supported should be private to device drivers populating
their dax_operations. I think it deserves a rename at this point.
dax_supported() knows how to route through multiple layers of stacked
block-devices to ask the "is dax supported" question at each level.

> I guess the last two can test a given range w/ blocksize; the first one
> only does blocksize; and the middle one also checks with whatever fs
> might be mounted? <shrug>
>
> (I ask because it took me a while to figure out how to revert correctly
> the brokenness in rc3-5 that broke my nightly dax fstesting.)

Again, apologies for that.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
