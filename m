Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4562F44F5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:13:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27EEC100EB85F;
	Tue, 12 Jan 2021 23:12:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F0B3100EB846
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:12:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e18so1529669ejt.12
        for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGsn2UyUP3f3na6HpANnUZFpv4jVtpQBApk9DBZ2Gw4=;
        b=mJx8H07xozAugMR08IjmnH99YqNMyG7AvCdzp0lUtUi+WFqXikF1A7cFTLCYRqMMyS
         su/cbiO9139LSx4oNtJriAgPKcustjjjz2z6MVdUXHEu0irCVAQABg+fqU4ZT8mbCsH9
         N5/jcm289ockwdjJzd5IkiPOhrhVhJu1yNYrnu389QNkUF7DnsGiK9Jv50sFRrtxCBV/
         FTu3yrR7XHsdv8Q8nGUS5hBCNWPyGgMqTx/tKqiGgeU0mu93q6A3bK+woYZfSi3COnJZ
         jy+pU+Sl19hAXD73sRSlt07gnSCoZ4LYcZTNyQOqQBT6TeVj7d9whu/8MhfjvW4o1ZqF
         XMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGsn2UyUP3f3na6HpANnUZFpv4jVtpQBApk9DBZ2Gw4=;
        b=lMKuC68ZhPtfCLfJxrP8sP4jB4EgbbS+Vwty5TdVI+1n3Pr0bUHrE4Lji/Aq3iyqTS
         VNa7uqlx27ohiEW/ia7seQ8F3aArbpGom+1iO6ONAI62AZVl2o03/UPk04ZyNV6qG+gV
         hij8xezXqo78wmHh6r+o2Awc2jLperLDRJI5Z3MM0no5fmp4cmvAPwHFdmBmjOMYa1WM
         cVMizP4hiqWfEJ6KwySMc9Vcw6Sw43UO1AD1+OnRt1a83l6GaO8pmmYcPjFYYZ11sorO
         3AqER5fSIJdSNBuzlZ/ujoeKsslewKc7GJNX05JGNufUteRUXn38DwMY1qhKHDjRUhdl
         gXCg==
X-Gm-Message-State: AOAM532aEcf2usqvos8xQducLREPm6etu3gviR7IIUel5h38HjqpDlU1
	mj9z9Mrmga0mAuMdqsqeKNTC5OhAOdrIibsqF8OQ9RvDfvI=
X-Google-Smtp-Source: ABdhPJwpirF72leFUYImeVHDQ/ZZ313G2n+UR19uQSpluzzOjMEuZIjdGxXRilA+sQR8X2aBR1Ad7tqFUC3m1+Y1BUY=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr571927ejk.323.1610521973666;
 Tue, 12 Jan 2021 23:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20210109153633.8493-1-redhairer.li@intel.com>
In-Reply-To: <20210109153633.8493-1-redhairer.li@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Jan 2021 23:12:44 -0800
Message-ID: <CAPcyv4h_n=0DkoRCXtqkpZfMuUNmpv5qNQeFJszaECRZ7vJY4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] msft: Add xlat_firmware_status for JEDEC Byte
 Addressable Energy Backed DSM
To: redhairer <redhairer.li@intel.com>, Vishal L Verma <vishal.l.verma@intel.com>
Message-ID-Hash: FNN66XITRSIXZFDNT7KTWVGP7CSDC4UV
X-Message-ID-Hash: FNN66XITRSIXZFDNT7KTWVGP7CSDC4UV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FNN66XITRSIXZFDNT7KTWVGP7CSDC4UV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ notify Vishal ]

On Sat, Jan 9, 2021 at 9:37 AM redhairer <redhairer.li@intel.com> wrote:
>
> From: Redhairer Li <redhairer.li@intel.com>
>
> Translate the status codes of the result of JEDEC Byte Addressable Energy Backed
> DSM to generic errno style error codes.
>
> Signed-off-by: Li Redhairer <redhairer.li@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
