Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC916ECC2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 18:40:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0931010FC3601;
	Tue, 25 Feb 2020 09:41:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15F1D10FC3600
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:41:21 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id g64so253028otb.13
        for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYtNZ1xT6uFxT8TBLjArkPtxeHvwasJTNpB6uOAhuuM=;
        b=vLp0hdjATiQFiYDWcV8uCuBKu/MDvQb4xSQ1J2o3Vxgi7RVy4e9ZsEWQQ575qDQTRW
         9Ew2R9vixKS3jn2cv6NlgWjfNAW6YIUurfP3C1fbwdwSoXA1YM/2EqIpb0ey5EVAye/2
         g7YFbsboxePJx3dlbwa2HI/49qSkNpDa3LJOffu0GP+ve/NRc8lQB3owKvwOeviY2mj4
         8eEE3QNGJ5yB88CHoSMU34so4iDVao/D5iWnq7tGoTPXsH1XupjeGJmpGiRQZtCG9hVm
         NR3A1af0MhepiT/G397PMavZQD/g6sbtFzQouSzq8W+0QnYrE5g1H1jpC0v0pok7NBHK
         rRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYtNZ1xT6uFxT8TBLjArkPtxeHvwasJTNpB6uOAhuuM=;
        b=LMjQYxtM5L5g01hAY+TwUNRtVFeH2o6iCGwMZY5qk6HUAEYX/yxqzr89R1qXS1Ls7t
         nTx9q8t+55tOM3TTLxoRgeXfUzH+bPalvN92MXFz20nzCevwiIUegpxXSVhkpI3IlxQP
         ZB4uMdwwBMIr+lQ97tX4pPCnGHyVHBax+VrIGFU037njLbspu94TkpvLS3jJCZtKLlGQ
         E+uC/5t6RlmTloFka5yqmObamLK+9Vfq5+sUDhOEmE4r9hlSRsiqxdwnB3rGdUql+oB4
         Qjgl5LutY3feuJN2dlxtHRMRWhYSVrnlvU7DvdO8d9CXSdxraTLFiq48ST6zrtOQPSKH
         cGXA==
X-Gm-Message-State: APjAAAUHMG9Il3T1CFTGhCI0hcM2GG96tewL/btHGJ7xBmEns4sQPJ2f
	jhUa60pkWhuaC+KiYDrxyaCv/v6Uf30/aPRXQyLeVw==
X-Google-Smtp-Source: APXvYqwGTSmHP8luhoLnsu9zg2hn84azyAtuqIl0pEBs9Aisv3xWMqq2Kqhgt07QP/Tmo0fTgzoRihjhPo9DWyzmYmA=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr42748771otl.71.1582652428399;
 Tue, 25 Feb 2020 09:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20200225161927.hvftuq7kjn547fyj@kili.mountain> <20200225162055.amtosfy7m35aivxg@kili.mountain>
In-Reply-To: <20200225162055.amtosfy7m35aivxg@kili.mountain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Feb 2020 09:40:17 -0800
Message-ID: <CAPcyv4h99vYcxgJ_9NKtYbhAGsifTG0JCRYq-j2t_CQinHZVcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: Out of bounds read in __nd_ioctl()
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: FNIDW6HKMVPSRN5JAU7DENV3MLXCRO6G
X-Message-ID-Hash: FNIDW6HKMVPSRN5JAU7DENV3MLXCRO6G
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FNIDW6HKMVPSRN5JAU7DENV3MLXCRO6G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2020 at 8:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "cmd" comes from the user and it can be up to 255.  It it's more
> than the number of bits in long, it results out of bounds read when we
> check test_bit(cmd, &cmd_mask).  The highest valid value for "cmd" is
> ND_CMD_CALL (10) so I added a compare against that.
>
> Fixes: 62232e45f4a2 ("libnvdimm: control (ioctl) messages for nvdimm_bus and nvdimm devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
