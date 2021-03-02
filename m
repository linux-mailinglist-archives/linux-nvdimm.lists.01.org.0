Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE26329606
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 06:16:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 851E4100EB832;
	Mon,  1 Mar 2021 21:15:59 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9378100EB825
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 21:15:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id a23so3294797pga.8
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 21:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSQJuB+mtSZLZwScg2lxxnjLCu3OD7M92dUP2X5sRCc=;
        b=ar93wfpr3JapIlnkTGXVPXq7siFk/y02kbVx6aMUH1mRh1hfqIN2vqijclSchl1GLF
         oa9NYUPTtu0/RiNUncxzdMrUuWCgPpPfTklPSe+FjF54GA4kRy6sozzUdNXDHR16gwm0
         +TBG77/2oqdEi2xPSZHXASiyfEP0s6rr/wvkH+HFHPsf20mluRcJo0kiZRz0RbKFvrob
         aeEd+wPxBQkbo1NE7tp+Ak6qy3oF6pszH9hIurVpoFcPE2BszFO+F0JcCAYv3sYv0AJG
         s6MWbixqWqNgfbUDU8zVdkmHn4pTESJU/ts9nnVXz0mtzXN1BsdWm7WdmHBC7SEIg+ug
         7jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSQJuB+mtSZLZwScg2lxxnjLCu3OD7M92dUP2X5sRCc=;
        b=Lfi8mNgCGO7CWMS/pKQ8OriVVQQ+iS+ZBNf02ZzMTo2rvMR0hZdRKnNZLXXvdgrbCr
         a0+eafyy0UI1mogTLTi6lBKbSPfEZd5w4yo7liqYgYJv+jTlHf2Fy30USJsN/6CB30nF
         b/zCPu9NoqObqQ4pWv7EPt595HSD3LHc35GAlF/frVNXvYci9PXRc0pbcJx8CXyDiRyg
         AlN8y09N3+4zUM3Ifxmx8Wnv70vUMTNOftQ6kq+gtByH/mrBFT/qFP47VDJDCsl2B6t8
         HU3OTtL2ssYHSOVG3/f+o5E3XEm7CBM18nGV+i57iktloG+xLWoZLSQ7BBSrUySvm8Ju
         /oLw==
X-Gm-Message-State: AOAM530IMYOlq2CNDRJhn1UlHTAB4Q5R2xueMkFgD5SfKcbwBG6cg0rw
	xIrjGTYekhLU9hV1tPmgje1W3g==
X-Google-Smtp-Source: ABdhPJzoYnXk7BqT1c6OyzZP8JH26M4z6e72Dr5QDH6UVtJ+HrBtIh+TiTSqGZrQr7JFhDtFL9JhpQ==
X-Received: by 2002:a62:ce:0:b029:1ee:3a86:8527 with SMTP id 197-20020a6200ce0000b02901ee3a868527mr1732032pfa.38.1614662155317;
        Mon, 01 Mar 2021 21:15:55 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id w202sm21026021pff.198.2021.03.01.21.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 21:15:55 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: QI Fuli <fukuri.sai@gmail.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH 1/2] configure: add checking jq command
In-Reply-To: <20210301172540.1511-1-qi.fuli@fujitsu.com>
References: <20210301172540.1511-1-qi.fuli@fujitsu.com>
Date: Tue, 02 Mar 2021 10:45:50 +0530
Message-ID: <87pn0iw2yh.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 2J5JRS3R7NYXQNMPSCOLJRA24GG2R27I
X-Message-ID-Hash: 2J5JRS3R7NYXQNMPSCOLJRA24GG2R27I
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2J5JRS3R7NYXQNMPSCOLJRA24GG2R27I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Qi,

QI Fuli <fukuri.sai@gmail.com> writes:

> Add checking jq command since it is needed to validate tests
>
> Cc: Santosh Sivaraj <santosh@fossix.org>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Link: https://github.com/pmem/ndctl/issues/141
> ---
>  configure.ac | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 5ec8d2f..839836b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -65,6 +65,12 @@ fi
>  AC_SUBST([XMLTO])
>  fi
>
> +AC_CHECK_PROG(JQ, [jq], [$(which jq)], [missing])
> +if test "x$JQ" = xmissing; then
> +	AC_MSG_ERROR([jq command needed to validate tests])
> +fi
> +AC_SUBST([JQ])
> +
>  AC_C_TYPEOF
>  AC_DEFINE([HAVE_STATEMENT_EXPR], 1, [Define to 1 if you have statement expressions.])
>
> --
> 2.29.2

Acked-by: Santosh Sivaraj <santosh@fossix.org>

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
