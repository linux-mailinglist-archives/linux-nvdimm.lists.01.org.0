Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D543662AD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 01:58:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A384F100EAB5C;
	Tue, 20 Apr 2021 16:58:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 423E0100EAB58
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 16:58:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mh2so39282986ejb.8
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGzMMFSDXVEyac1L/55cUpZpjU4bjjoWfcDw+JMob04=;
        b=ytcrxr8wbn8/5f4pqgMPFBPjgsUCFDMD5TM1ZAF0QU4PlCzmA8rMWxyXrHIAUt0ou2
         likfPwJsXJQb9HKQzvOOmw0EhLFS3MQYnmxFxXqw2N1399atYkC1XYjiqJj7RqqZh4+Q
         JpWAi5g7hqpN3qL0OWufzjzfNHRViTkPpLCVFo00Ni2WG0UFdHbw62zSVLySFf3Ux9Ka
         Bb6IqTZJaiE/gB4S1CMCofM9zPtdLM03pVYgiWdHXM4uWAjTIyKcEJgiFSB8qSl5zI5W
         vlnn3bLaR42S3SQYoNYpzQe1aOgvkvlInqtvY8boxyTwfsbKB17BmZgvK3HsgJ1wER3g
         g3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGzMMFSDXVEyac1L/55cUpZpjU4bjjoWfcDw+JMob04=;
        b=qJwsPzo3p/M0lPzpIQ9XRNzIs9hf94NvqaNK7TgmyNXTGlZWXGfJOTmz/zNXHE9MPj
         IkLWWDSUdp5XmFLq5sE1BFoXlvmMj6fwPMJXoF6UO8NiN99z62SDtSlpR7ZDk4ULvfPb
         92nHDG2QxH5yujq1IXWCyq1qV9xCTdxGoujRSjuzOYKoRDtVg5M/rGr2IJ2UzQoK6Kzr
         sYbPX3nNWsBLMjP1F9KPcTN3eWfHk0OCN6Fa0v7MyTbyPTmHf9iaq4TIZS2Ky6mN70JQ
         jShG/mQstXr1oBa+ARvj/O1D2fO8SEQz9CzDPzgaRY5sozAuyZJcb0iqUGhUfLN1AC2i
         3sfQ==
X-Gm-Message-State: AOAM533SzHCMWVrTMLPBYx/EdVQHvxVY/ojs+uiBG2ZiT7RWhdkAd+Is
	kUBWsv0EPIe7mO9wPNpqUm4Vwb4EH3DCRVu+zr00Qw==
X-Google-Smtp-Source: ABdhPJyz2D3hyXViWoO0yuscrp5I4sCJibwSSLOeRSpnxbMCw7pAbd5G4W4YTnawc/5sPprgOM8OCcCPsMSFL51a71M=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr30069454ejc.418.1618963094537;
 Tue, 20 Apr 2021 16:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Apr 2021 16:58:06 -0700
Message-ID: <CAPcyv4hV1HhFRw42s=tc_8dLeY4+avB_2jauSxVzUBzKsEr8ew@mail.gmail.com>
Subject: Re: [PATCH -next v2] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
To: Zou Wei <zou_wei@huawei.com>
Message-ID-Hash: 2AYT3TQR3BXPPVKHJF3A5B2LAZNRKGE6
X-Message-ID-Hash: 2AYT3TQR3BXPPVKHJF3A5B2LAZNRKGE6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2AYT3TQR3BXPPVKHJF3A5B2LAZNRKGE6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 20, 2021 at 12:31 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>  symbol '__nfit_test_ioremap' was not declared. Should it be static?
>
> This symbol is not used outside of iomap.c, so this
> commit marks it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Looks good to me, thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
