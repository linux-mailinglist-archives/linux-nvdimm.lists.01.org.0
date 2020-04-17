Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1711AE8BB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 01:55:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8686D100DCB9D;
	Fri, 17 Apr 2020 16:55:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6006100DCB9C
	for <linux-nvdimm@lists.01.org>; Fri, 17 Apr 2020 16:55:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s9so2861629eju.1
        for <linux-nvdimm@lists.01.org>; Fri, 17 Apr 2020 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=453k+sSBzEUPOdDqBbcPAhnE5CqyaEgRScdPj0XtgZ0=;
        b=w3ik+6fFxB5XeGvLPG1swJwBWELSqJfh1vpfu/q0fETqmDmztanQBYj72fl299xd07
         nplfj85E5RDeb9R+1j05/WrwW0CXecFYLIrhGBFJDiJabl68eAkH0LjXuNCqYzU6LJIf
         zDPyB3SGJ33zuKe8LMlOk3yOStmady8VpQ858g2YDSL6qpN77WfLlnmPqq1dCUo8Dq4y
         btY4TtQAnH+TCLl6Th6gvKnlE6xp/whQh1W0/77RwqGWJ/9dnm9ZbG+YBoV9DhGe+uwL
         k/FphrGIKeuELxN3CllO1cqpsyoN6t7F4pEVNrqY1/ehVMT7DntueJHK8nhzdvuVbDmO
         cEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=453k+sSBzEUPOdDqBbcPAhnE5CqyaEgRScdPj0XtgZ0=;
        b=L3Xswuj8CTJnn2xzsaG5z8z9fbD4MmWJcULEEeeRziFhBDdyjYv4JJrRfIpexXZV7f
         fMwfJv+P74yQTXT7OHLoDrUHOV2SgPnDTVuXkVfOQMxFQjLxSwtMilaWzRs9ftSWSYvm
         ceUCkzROpLVRV8gtcRyMvNbbAnb/xHzqi7jsrx0ILcnr2TqzgxmoPYtr7UD5aHsHNBxR
         raGCFA3UtDsKuztEoXmdmtt1/lMyAiDE6kGQ388ei6W083Y6nfT37drJjaFQTK+QZofn
         3RHk3v2T9Bmbdp2KaWPWbMdO7CBCwIQmSf9YYtjWW/4kSobdsC+2OVcrHN4OfjfCp5jd
         KUwQ==
X-Gm-Message-State: AGi0Pua+xc1kwD0ZYUUcah+QSFDE36FUP5SiCYUgYe0G1RUvSSmDBzcZ
	WQuCKF03NjPA+gM1r6jjHATAXh3umFW17Z05cODndQ==
X-Google-Smtp-Source: APiQypJp9NQ86ZACrxyDG7uNiPUT0j/uBuCZoYfvaokYMx0Lf+tLeNKpIPNKV9OyQLZXftdBqmIBigjUlaQXJbsLl3I=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr5533705ejb.201.1587167730255;
 Fri, 17 Apr 2020 16:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200416081314.2637325-1-santosh@fossix.org>
In-Reply-To: <20200416081314.2637325-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 17 Apr 2020 16:55:19 -0700
Message-ID: <CAPcyv4iQJ3qMovByZHCTXqgH-Z9g1HQcjEhQp_nGxQmnrP=wSA@mail.gmail.com>
Subject: Re: [ndctl PATCH v2] Skip region filtering if numa_node attribute is
 not present
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: YOT5ADDUMHASJFWKMCVK5SPPFJSHEYZP
X-Message-ID-Hash: YOT5ADDUMHASJFWKMCVK5SPPFJSHEYZP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YOT5ADDUMHASJFWKMCVK5SPPFJSHEYZP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 16, 2020 at 1:14 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> For kernel versions older than 5.4, the numa_node attribute is not
> present for regions; due to which `ndctl list -U 1` fails to list
> namespaces.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
