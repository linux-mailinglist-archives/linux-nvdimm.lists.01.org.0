Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D77B2C48AB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 20:45:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1344E100EF255;
	Wed, 25 Nov 2020 11:45:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=ritundailb333@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0382C100EF254
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 11:45:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s8so3075286wrw.10
        for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=ijVS8wUG3QwdetotYuN3REyWbIEoH3Ho/x0z6dbbf5q+7FFvDE/GuvwKiU4updntdW
         voFY1UU8Q6QqIkl5K5ujyVt7q5P/rnEnthHSQFJbhSCqoOL4tSDq13hGrTngDNme9/3L
         BdLTP4tfgoTIylFUhE4hbnicXBXRkKTWRDH/1zrs7zqtlgXYM7YWg07Jorjba+fC9w6K
         9RtLyTj0hHUn9HGxt6MFAqORxmw8cYsDXn4DC6DefByxtekpr1v0DVYO2yFt352fCD9D
         Ktdxrvy7GH2/O0CCpRrvACbOI0OvPY857/tg40d3Yq4foOR5BjToYi+xY35Bje0jvQUM
         EF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=Lqah/1LyVNnkPbL/DQlGsLmnlnrgY5IJS+Nzo5LA5uz5l+vkJ9Blf6ZtETJikZ3iCx
         2DMFf7mUXyCIssKzQSbR2wRE0YMC1MwRhNyWMdCHXHkvXy2QeTBaz9MbElK4ByeDc1M2
         uSj7c7akczVE5N2mVFTfSoNcFB04FHg1iiS1TOxMeWEoFZzYcp6ERZ5OKsRhSTAEdCem
         APQUVbwYRqRATC3tqJfjGoGwOHViyOMgjyxIlltknHwCyZAnc9XNSofEQHTnfTCurglQ
         LSCPHygyWlXOWUthJhms60ANIfr0idYogpCVmxz9XMzuyZA/yNZ6kH3aC07GDXt8vs1a
         EV2g==
X-Gm-Message-State: AOAM532+WFIptFLHwkxhuJ9aVJgnYlrt0sEZ5Ppj8lPecU4Ns9wwlbzI
	TsIiyQ6PPAM864SHXdCT5DA=
X-Google-Smtp-Source: ABdhPJxzr4Q0zuyxrkko/CfocHprWuP1vkYbXOdCVimHLwYFXWrdsnSECjDz+/TaEpVn/2l5MjC9Ig==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr5716440wrv.127.1606333537507;
        Wed, 25 Nov 2020 11:45:37 -0800 (PST)
Received: from [192.168.1.152] ([102.64.149.89])
        by smtp.gmail.com with ESMTPSA id s2sm5757848wmh.37.2020.11.25.11.45.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2020 11:45:36 -0800 (PST)
Message-ID: <5fbeb460.1c69fb81.29222.d00f@mx.google.com>
From: "Dailborh R." <ritundailb333@gmail.com>
X-Google-Original-From: Dailborh R.
MIME-Version: 1.0
Content-Description: Mail message body
Subject: Please reply to me
To: Recipients <Dailborh@ml01.01.org>
Date: Wed, 25 Nov 2020 19:44:41 +0000
Message-ID-Hash: MS36WBB5QVQ4MUJPZGP4KNKVAD73AQRP
X-Message-ID-Hash: MS36WBB5QVQ4MUJPZGP4KNKVAD73AQRP
X-MailFrom: ritundailb333@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: dailrrob.83@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MS36WBB5QVQ4MUJPZGP4KNKVAD73AQRP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm Dailborh R. from US. I picked interest in you and I would like to know
more about you and establish relationship with you. i will wait for
your response. thank you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
