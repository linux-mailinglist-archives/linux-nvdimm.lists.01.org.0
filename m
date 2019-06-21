Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15E4DE47
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 02:59:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70D302129F0F3;
	Thu, 20 Jun 2019 17:59:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5DD32129F0EC
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 17:59:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w79so3504859oif.10
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wLJ4QD84/Mb0q65SUfO1dqn1Yx37fdhBGRJv3XoJNF0=;
 b=zcFi9/Dwem431a/RiCV993Rbdtb64QLJQWb7RyOYrdjhjSNeF/NINq0b0r9CxOJWRW
 NNVocLoSCpdmJhsE5FO9RWqmSwagnfT2/CGDnBg0lAnRwocP0JUnfa+BLOSHRY53ItVO
 WXE4OI12gqmWBiuIkZOfFZUkQHEnFnQuZ88BbfNEjzqsdU78apIxAkZPShvpMBkWUEgG
 Yp4zoG5nW0WVkTdsXlmaoAbFlbft/l1hdfCDHc+zPUnjLfMysJDtLY2ewc5RuetKH1pi
 kB+l8/5uB5pZdkNnzyxim5LsRiD0XUbTEDSVCbKHZU20Lau1A0LiWxSG8xrpqYufBpvS
 mNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wLJ4QD84/Mb0q65SUfO1dqn1Yx37fdhBGRJv3XoJNF0=;
 b=AgixuxUbKxhBQF/qSLNROEKCmUZpl38IsmcF7GdYv9NlAqvlBq+EBJy3IcMdk+VEvB
 pyZtelI1ihMZNsYH7WF/PlhxHMa56KZMsV8RgDGTvUH6/oVG794COZgMz003m8pCAhzP
 4Yhn6oSdwixyu5rQ9lsms8vxOpXIcLO+sNy0YhA9bbW9STxJpClb2viucr1H/GPoiGd+
 ev6U/2bg+5RIj2oez5yoIzcvD1FxtUxBRn6OWEipJsLLJIwZRpGj+bG3kkHp2I5oPx1M
 /s5yEc+sbbBRsYueWlU3csZdsGwhf+q6R3DAm7LFHsEn0cXe+YUj92PHjZPpNBUUB6nl
 +L2Q==
X-Gm-Message-State: APjAAAXfz83emu7BrVUuVxFlU2fBnwokBEc/YmB4MAIalUhZ/Lc3YqjR
 /L3lXBYJAZgFmU5wZF7qnEqb4l5D+wiWw1ZnXQpeyw==
X-Google-Smtp-Source: APXvYqwWDUk0UtkJR1/TmjhHXe+amq3pVYxYrT8CQbs/K1bPjgvgFbelpiEl/6Zyz3FAmYpfJ/du9xKlT58WDqCqlxA=
X-Received: by 2002:aca:1304:: with SMTP id e4mr1081464oii.149.1561078754728; 
 Thu, 20 Jun 2019 17:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190607052558.15037-1-santosh@fossix.org>
In-Reply-To: <20190607052558.15037-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Jun 2019 17:59:03 -0700
Message-ID: <CAPcyv4h0dXXrw55H1f7QHz8RaLSsJAG5h9wXcB2fUtRCb4K3dA@mail.gmail.com>
Subject: Re: [ndctl PATCH] Enable ndctl tests for emulated pmem devices
To: Santosh Sivaraj <santosh@fossix.org>
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
Cc: harish@linux.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 6, 2019 at 10:26 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> For QEMU emulated devices, nfit drivers need not be loaded, also the
> nfit_test, libnvdimm_test modules are not required. This patch adds a
> configure option to enable testing on qemu without nfit dependencies.

This looks useful, I only quibble with it being a compile time option.
I'd prefer an environment variable to allow this to be overridden at
test run time, perhaps "WITH_NFIT". You can have a compile time option
to set the WITH_NFIT default, but otherwise it would be useful to be
able to disable NFIT requiring tests even on x86.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
