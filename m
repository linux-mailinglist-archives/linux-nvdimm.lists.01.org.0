Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B7741BD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jul 2019 00:52:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38FCB212DC5D5;
	Wed, 24 Jul 2019 15:55:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E044E212DA5FA
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 15:55:09 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so36274110oih.4
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NS4u+eBseg0DbQA0MU2dSuty1nFLg/yD2ulnxgZWxpw=;
 b=WsI01r0+8S0qHaiUGli9O6VA8G5EbT8wESR+QHOUxt+/JeNKOPhQaHmPMTMh8KeJhi
 knfyeHmKxGpmpur/ltSGLunAHSSg6BCDIPy3rFyWNIOzGn6KeOBjFf0EWl/VovTwjw2Z
 ZF8lTd/ZFvMgkJB+p8yHYfJm6eUvMH5ebX5U6dNhiA2NEsSOM47/uSHe0/CI8vqIrIy5
 nzEgeRtmzAJl4ArzmC9enkYIQ7bvu4mXazcyXaOupfOvh1MFtfCZ8BS9ALKmFxbZDY2/
 mtnlrYGHU8qf5gw0Pziar4dwHIBm8siMjy/LtAfsWqykl6JFTDPIFrc6TJvZvHVV6sf/
 /5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NS4u+eBseg0DbQA0MU2dSuty1nFLg/yD2ulnxgZWxpw=;
 b=Eikq5rZXHwH5HrD+DmPb2j4JUlvSXUi0vivRUOnLWRfXaPZ4Sff88PeUsCExcnC84V
 SB4ncHyITD7XWrlGqCWL6vReV2/ojCmeXmznGX1zCu+3yn0M41ITjU4CymNORhPWU5gK
 S945QPJim3cW80WWcKPV9qm0YnrR9xArCXsnNrMsO8D8O+BfQc5G2pLVIPl+r00VHQ6J
 8ngM68fE5vxu8wl88+/gdIlV4C2EM0OUtlTuLZzm3/83EbNh8NKz10ksccQdC25izD20
 lAsFGMmULKR7iLyrj3HFryr3/6VbCrVWR4AJbkRzmQGnLH056OFG5NJtcnV3S+ASwN/M
 cNjw==
X-Gm-Message-State: APjAAAVJ4pSNXQ49PK0LUcdPilCK+tqFeHAnmiz7tNr8Tv1R4LMstDCg
 zJYUzAfn4shwwcZMQvTSeqLQ/493OfEyNHd4QK71XQ==
X-Google-Smtp-Source: APXvYqzSZInaKhuMFiPlmjU3dlvlT2OJR7ptIKglkJzXRv3bZsRsA+zEBuvwUDFgRbzKWlufzZxuvok65bNWe4q/BNE=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr40944549oii.0.1564008761619; 
 Wed, 24 Jul 2019 15:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Jul 2019 15:52:30 -0700
Message-ID: <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
To: Jane Chu <jane.chu@oracle.com>
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
Cc: Linux MM <linux-mm@kvack.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 3:35 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Changes in v2:
>  - move 'tk' allocations internal to add_to_kill(), suggested by Dan;

Oh, sorry if it wasn't clear, this should move to its own patch that
only does the cleanup, and then the follow on fix patch becomes
smaller and more straightforward.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
