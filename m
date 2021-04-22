Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D73E36875F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 21:43:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78408100EC1D5;
	Thu, 22 Apr 2021 12:43:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c42; helo=mail-oo1-xc42.google.com; envelope-from=robcc1973@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D183100EC1C6
	for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 12:43:46 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso3399796oos.6
        for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=wE7eNMsCuqhE+Uhw7rHS6oVphe6W6yuR0fdbuzZIiDQ=;
        b=l/cMYgfXruplDKzn1ndk+xmIuaeCTwmFP+DsxWeQz/gKhTFFxCl/9jjo6BldnJTNKW
         U9TM45Jl2XQW81mogH40rEDeXN2/ILUHmTKq6eFaLpRf5dDRZJu9JA/iQ5VvdYGDz0FG
         rr+TYO07iogQe6n5lVcv2Ls3udiwDMjc3YaV4nW68ZmyarvZwcz38KbjrK2fR0ql5QRw
         6DdwVmUwaXexFdHznVQVyfvGUYwA1PCBl7AP2vlm7xUk6OgESNpx5w3Mc7fhq9kQoZuI
         qrfvuqhxNb6g228Tmm/zH/KSPBoGDv1k1JthKlpKqAcvxUiBzt1apPtP+JCsyjTdW60a
         dvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=wE7eNMsCuqhE+Uhw7rHS6oVphe6W6yuR0fdbuzZIiDQ=;
        b=lIqo+QMIpe2CqKQaLh+F/fFgY8H6A2QV3zJQlTYQ3bLI9215AlbTMYokiFlDrcdT/2
         wnvvtuiTTvbtNH86uc6u73QcqPhrq7nfzf1W76RzvTqDKjrETb7llSBADQa3UwFRckS2
         H4clRkS1eQ933XvH+8vX1i6EO5aJWfFhWeK4nK06YTGvLJVHXLKE+sSxPe70jRSiDYGI
         hVlT9fzfQS+UmtxS4BhYtxiJQixNyrB1P+qNxZZNUdNHtgT+7/Q4/OFZwC7Z4LROAwuD
         ubJmw4+9a12fhmYTjGrSWvcghwzqwV+/M6N6FCeMn4Z3m8q+WaVw3FQU+ObYhbNeHRS1
         lEAA==
X-Gm-Message-State: AOAM531rVdXMpy1Qynwx2/acKZwlAXf+3A+CpbKgNo2szJCrnLXUk9Bm
	W4FVTO9z0DH/0lnXnxb3jUO+Y/ya36XYy5HkrHs=
X-Google-Smtp-Source: ABdhPJwkVoiheFUFjOJln7Bb/yYwShYuMSmUa4SrWQKBJZEeNLhZRgE0YvaHb7xHs6GASllJDhrON9cOi4cPB4P20IU=
X-Received: by 2002:a4a:a223:: with SMTP id m35mr115527ool.39.1619120625564;
 Thu, 22 Apr 2021 12:43:45 -0700 (PDT)
MIME-Version: 1.0
From: Robert <robcc1973@gmail.com>
Date: Thu, 22 Apr 2021 20:44:08 +0000
Message-ID: <CAO0LBdUx_3=-UgvOMhOmqhh6m_EKFFearJFxK0PSdUT+HAM82A@mail.gmail.com>
Subject: WE Contact You
To: undisclosed-recipients:;
Message-ID-Hash: 6AWJ77UDE4TVWXB5LOHBYO5PKZNH2OJE
X-Message-ID-Hash: 6AWJ77UDE4TVWXB5LOHBYO5PKZNH2OJE
X-MailFrom: robcc1973@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: robserviceltd1@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6AWJ77UDE4TVWXB5LOHBYO5PKZNH2OJE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear,


greetings to you..

Do you need a loan to fund a project or to expand your business? Are you
looking for a partner in a Joint Venture(JV)? We will help you accomplish
your dream in a matter of days. Our Lenders/Investors offer funds for all
kinds of businesses at very low and business friendly rates.

I'm looking forward to hearing from you.

For further details :

Regards,

Robert
Agent
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
